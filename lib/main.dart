// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/api/api.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/models.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student_hub/routes/routes.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/view-models/view_models.dart';
import 'package:get/get.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await LocalNotification.init();
  final ProfileService profileService = ProfileService();
  final AuthService authService = AuthService();
  final ProposalService proposalService = ProposalService();
  final NotifiactionService notifiactionService = NotifiactionService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => IndexPageProvider()),
        ChangeNotifierProvider(create: (_) => OpenIdProvider()),
        ChangeNotifierProvider(create: (_) => GlobalProvider()),
        ChangeNotifierProvider(create: (_) => ProjectProvider()),
        ChangeNotifierProvider(
            create: (_) => ProfileCompanyViewModel(
                profileService: profileService, authService: authService)),
        ChangeNotifierProvider(
            create: (_) => ProfileStudentViewModel(
                profileService: profileService, authService: authService)),
        ChangeNotifierProvider(create: (_) => UserProvider(null)),
        ChangeNotifierProvider(
            create: (_) =>
                ProposalStudentViewModel(proposalService: proposalService)),
        ChangeNotifierProvider(
            create: (_) => NotificationViewModel(
                notificationService: notifiactionService)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final NotificationViewModel notificationViewModel =
        Provider.of<NotificationViewModel>(context, listen: false);

    Get.put(userProvider);

    Future<void> initializeProviders() async {
      ThemeProvider themeProvider =
          Provider.of<ThemeProvider>(context, listen: false);

      await Future.wait([
        userProvider.initializeProvider().then((value) {
          getToken().then((value) {
            handleListenNotification(
                userProvider.currentUser!.userId,
                value!,
                notificationViewModel,
                userProvider.currentUser!.currentRole,
                context);
          });
        }),
        themeProvider.initializeProvider(),
      ]);
    }

    return FutureBuilder(
      future: initializeProviders(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primary_300),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Text(
              'Error: ${snapshot.error}',
              textDirection: TextDirection.ltr,
            );
          } else {
            final ThemeProvider themeProvider =
                Provider.of<ThemeProvider>(context);
            final ProjectProvider projectProvider =
                Provider.of<ProjectProvider>(context);
            Get.put(projectProvider);

            ImageList.loadImage(context);

            SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.black,
              ),
            );
            return GlobalLoaderOverlay(
              useDefaultLoading: false,
              overlayWidgetBuilder: (_) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: primary_300, size: 40),
                );
              },
              child: GetMaterialApp(
                localizationsDelegates: const [
                  ...AppLocalizations.localizationsDelegates,
                  MonthYearPickerLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                locale: Locale(themeProvider.getLanguage),
                routes: userProvider.currentUser != null
                    ? (userProvider.currentUser!.currentRole == Role.student
                        ? StudentRoutes.routes
                        : CompanyRoutes.routes)
                    : AuthRoutes.routes,
                initialRoute: userProvider.currentUser != null
                    ? (userProvider.currentUser!.currentRole == Role.student
                        ? StudentRoutes.nav
                        : CompanyRoutes.nav)
                    : themeProvider.getIsFirstCall
                        ? AuthRoutes.intro
                        : AuthRoutes.login,
                debugShowCheckedModeBanner: false,
                theme: themeProvider.getThemeMode
                    ? AppTheme.darkTheme
                    : AppTheme.lightTheme,
              ),
            );
          }
        }
      },
    );
  }
}

void handleListenNotification(int userId, String token,
    NotificationViewModel nvm, Role currentRole, BuildContext context) {
  SocketApi.init(token);
  SocketApi.getNotificationModel(userId, currentRole, nvm).listen(
    (NotificationModel data) {
      final String numChat = nvm.numberOfChat['${data.senderId}'] != null &&
              nvm.numberOfChat['${data.senderId}']! > 1
          ? '(${nvm.numberOfChat['${data.senderId}']})'
          : '';

      final String title = data.typeNotifyFlag == TypeNotifyFlag.chat
          ? '${AppLocalizations.of(context)?.newMessages} $numChat'
          : data.typeNotifyFlag == TypeNotifyFlag.interview
              ? '${AppLocalizations.of(context)?.newMeeting}'
              : data.typeNotifyFlag == TypeNotifyFlag.offer
                  ? '${AppLocalizations.of(context)?.newOffer}'
                  : data.typeNotifyFlag == TypeNotifyFlag.submitted
                      ? '${AppLocalizations.of(context)?.newProposal}'
                      : '${AppLocalizations.of(context)?.successfulHired}';

      final String content = data.typeNotifyFlag == TypeNotifyFlag.chat
          ? '${data.sender?.fullname} (${AppLocalizations.of(context)?.sender}): ${data.message!.content}'
          : data.typeNotifyFlag == TypeNotifyFlag.interview
              ? '${AppLocalizations.of(context)?.notifInterview} "${data.message!.interview!.title}" ${AppLocalizations.of(context)?.from} ${data.sender?.fullname} ${AppLocalizations.of(context)?.at} ${Helpers.formatDateTimeToCustom(data.message!.interview!.startTime)}.'
              : data.typeNotifyFlag == TypeNotifyFlag.offer
                  ? '${AppLocalizations.of(context)?.notifOffer} ${data.sender?.fullname} ${AppLocalizations.of(context)?.company}.'
                  : data.typeNotifyFlag == TypeNotifyFlag.submitted
                      ? '${data.sender?.fullname} ${AppLocalizations.of(context)?.notifSumitted} "${data.content.split(' ').last}".'
                      : '${data.sender?.fullname} ${AppLocalizations.of(context)?.notifHired} "${data.content.split(' ').last}"';
      LocalNotification.showScheduleNotification(
        title: title,
        body: content,
        payload: title,
        duration: 0,
        id: data.id,
      );
    },
    cancelOnError: false,
    onError: print,
    onDone: () {
      print('*** NotificationModel.1 stream controller Done ***');
    },
  );
}
