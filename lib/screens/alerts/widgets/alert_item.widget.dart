import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/services/api.services.dart';
import 'package:student_hub/models/chat/video_conference.model.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/routes.dart';
import 'package:student_hub/styles/styles.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:student_hub/widgets/widgets.dart';

class AlertItem extends StatelessWidget {
  const AlertItem(
      {super.key,
      required this.notif,
      required this.img,
      required this.title,
      required this.content});

  final NotificationModel notif;
  final String img;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;

    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser?.userId;
    final String timeCreated =
        Helpers.calculateTimeFromNow(notif.createdAt!, context);
    final NotificationViewModel notificationViewModel =
        Provider.of<NotificationViewModel>(context, listen: false);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final ProjectProvider projectProvider =
        Provider.of<ProjectProvider>(context);

    void handleClickMessage() {
      ProjectModel project = ProjectModel(id: notif.message!.projectId!);

      notificationViewModel
          .updateMessageNotificationRead(notif.senderId)
          .then((value) {
        notificationViewModel.fetchNotification(
            userId: userProvider.currentUser?.userId,
            currentRole: userProvider.currentUser!.currentRole);
      });
      if (notif.receiver?.id == userId) {
        Navigator.of(context).pushNamed(CompanyRoutes.chatScreen, arguments: {
          'user': notif.receiver,
          'otherUser': notif.sender,
          'project': project
        });
      } else {
        Navigator.of(context).pushNamed(CompanyRoutes.chatScreen, arguments: {
          'user': notif.sender,
          'otherUser': notif.receiver,
          'project': project
        });
      }
    }

    void handleClickInterview() {
      VideoConferenceModel videoConferenceModel = VideoConferenceModel(
        userID: userProvider.currentUser!.userId.toString(),
        userName: userProvider.currentUser!.fullname,
        callID: notif.message!.interview!.id.toString(),
      );
      Get.toNamed(CompanyRoutes.videoConference,
          arguments: videoConferenceModel);
    }

    void handleAcceptOffer() {
      ProposalService ps = ProposalService();
      context.loaderOverlay.show();
      ps
          .updateProposalStatusFlag(notif.proposal!.id, StatusFlag.hired)
          .then((value) {
        Get.back();

        MySnackBar.showSnackBar(
          context,
          'The offer was accepted. Wishing you a successful project ♥',
          title,
          ContentType.success,
        );
      }).whenComplete(() {
        context.loaderOverlay.hide();
      });
    }

    Future<ProjectModel> handleGetProjectById() async {
      try {
        ProjectService projectService = ProjectService();

        Map<String, dynamic> data =
            await projectService.getProjectById(notif.proposal!.projectId);
        return ProjectModel.fromMap(data);
      } catch (e) {
        throw Exception('Failed to get project');
      }
    }

    void handleClickOffer() async {
      context.loaderOverlay.show();
      await handleGetProjectById().then((value) async {
        Project project = Project(
          id: notif.proposal!.projectId,
          createdAt: DateTime.parse(value.createdAt!),
          description: value.description,
          title: value.title,
          completionTime: value.projectScopeFlag,
          requiredStudents: value.numberOfStudents,
          proposals: notif.proposal,
          favorite: false,
        );
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            isScrollControlled: true,
            builder: (ctx) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ProjectDetails(
                  project: project,
                  viewType: ProjectDetailsView.viewOffer,
                  acceptOffer: () {
                    handleAcceptOffer();
                  },
                ),
              );
            });
      }).catchError((e) {
        throw Exception(e);
      }).whenComplete(() => context.loaderOverlay.hide());
    }

    void handleClickProposal() async {
      await handleGetProjectById().then((value) async {
        Project project = Project(
          id: notif.proposal!.projectId,
          createdAt: DateTime.parse(value.createdAt!),
          description: value.description,
          title: value.title,
          completionTime: value.projectScopeFlag,
          requiredStudents: value.numberOfStudents,
          proposals: notif.proposal,
          favorite: false,
        );
        projectProvider.setCurrentProject = project;
        Get.toNamed(CompanyRoutes.proposalDetail,
            arguments: notif.proposal!.id);
      }).catchError((e) {
        throw Exception(e);
      });
    }

    void handleClickNotification(BuildContext context) {
      if (notif.notifyFlag == NotifyFlag.unread) {
        NotifiactionService notifiactionService = NotifiactionService();
        notifiactionService.updateNotificationRead(notif.id);

        if (notif.typeNotifyFlag != TypeNotifyFlag.chat) {
          notificationViewModel.fetchNotification(
              userId: userProvider.currentUser?.userId,
              currentRole: userProvider.currentUser!.currentRole);
        }
      }

      switch (notif.typeNotifyFlag) {
        case TypeNotifyFlag.chat:
          handleClickMessage();
          break;
        case TypeNotifyFlag.interview:
          handleClickInterview();
          break;
        case TypeNotifyFlag.offer:
          handleClickOffer();
          break;
        case TypeNotifyFlag.submitted:
          handleClickProposal();
          break;
        case TypeNotifyFlag.hired:
          break;
      }
    }

    return Opacity(
      opacity: notif.notifyFlag == NotifyFlag.read ? 0.5 : 1,
      child: Card(
        child: InkWell(
          onTap: () {
            handleClickNotification(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            margin: const EdgeInsets.only(bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DisplayText(
                          text: title,
                          style: textTheme.labelMedium!,
                          overflow: TextOverflow.visible,
                        ),
                        const Gap(5),
                        DisplayText(
                          text: timeCreated,
                          style: textTheme.labelSmall!.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.7),
                              fontSize: 12),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    const Gap(5),
                    SizedBox(
                      width: deviceSize.width - 100,
                      child: DisplayText(
                        text: content,
                        style: textTheme.labelSmall!.copyWith(fontSize: 13),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    const Gap(10),
                    if (notif.typeNotifyFlag != TypeNotifyFlag.submitted &&
                        notif.typeNotifyFlag != TypeNotifyFlag.chat &&
                        notif.typeNotifyFlag != TypeNotifyFlag.hired)
                      ElevatedButton(
                          style: buttonGreen,
                          onPressed: () {
                            handleClickNotification(context);
                          },
                          child: DisplayText(
                            text:
                                notif.typeNotifyFlag == TypeNotifyFlag.interview
                                    ? 'Join'
                                    : 'View offer',
                            style: textTheme.labelSmall!.copyWith(
                              color: Colors.white,
                            ),
                          ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
