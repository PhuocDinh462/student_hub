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

    Get.put(userProvider);

    Future<void> initializeProviders() async {
      ThemeProvider themeProvider =
          Provider.of<ThemeProvider>(context, listen: false);
      handleListenNotification(userProvider.currentUser!.userId);
      await Future.wait([
        userProvider.initializeProvider(),
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

void handleListenNotification(int userId) {
  SocketApi.init();
  SocketApi.getNotificationModel(userId).listen(
    (NotificationModel data) {
      print('Asset.1: $data');
    },
    cancelOnError: false,
    onError: print,
    onDone: () {
      print('*** asset.1 stream controller Done ***');
    },
  );
}
