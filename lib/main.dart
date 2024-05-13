// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
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
import 'package:student_hub/widgets/display_text.dart';

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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Hand-coding.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Gap(20),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primary_300),
                    ),
                    const Gap(10),
                    DisplayText(
                      text: 'Waiting...',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 14),
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
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
  SocketApi.getNotificationModel(userId).listen(
    (NotificationModel data) {
      final String numChat = nvm.numberOfChat['${data.senderId}'] != null &&
              nvm.numberOfChat['${data.senderId}']! > 1
          ? '(${nvm.numberOfChat['${data.senderId}']})'
          : '';

      final String title = data.typeNotifyFlag == TypeNotifyFlag.chat
          ? 'New messages $numChat'
          : data.typeNotifyFlag == TypeNotifyFlag.interview
              ? 'New meeting'
              : data.typeNotifyFlag == TypeNotifyFlag.offer
                  ? 'New offer'
                  : data.typeNotifyFlag == TypeNotifyFlag.submitted
                      ? 'New proposal'
                      : 'Successful hired';

      final String content = data.typeNotifyFlag == TypeNotifyFlag.chat
          ? '${data.sender?.fullname} (sender): ${data.message!.content}'
          : data.typeNotifyFlag == TypeNotifyFlag.interview
              ? 'You have a meeting titled "${data.message!.interview!.title}" from ${data.sender?.fullname} at ${Helpers.formatDateTimeToCustom(data.message!.interview!.startTime)}.'
              : data.typeNotifyFlag == TypeNotifyFlag.offer
                  ? 'You have a new offer from ${data.sender?.fullname} company.'
                  : data.typeNotifyFlag == TypeNotifyFlag.submitted
                      ? '${data.sender?.fullname} has submitted a proposal for your project "${data.content.split(' ').last}".'
                      : '${data.sender?.fullname} has been hired for the project "${data.content.split(' ').last}"';
      if (!data.title.contains('cancelled')) {
        nvm.addNotification(data, currentRole);
        LocalNotification.showScheduleNotification(
          title: title,
          body: content,
          payload: title,
          duration: 0,
          id: data.id,
        );
      }
    },
    cancelOnError: false,
    onError: print,
    onDone: () {
      print('*** NotificationModel.1 stream controller Done ***');
    },
  );
}
