import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/auth_route.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/routes/student_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student_hub/utils/image_list.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => IndexPageProvider()),
        ChangeNotifierProvider(create: (_) => OpenIdProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => PostJobProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
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
    return FutureBuilder(
      future: Provider.of<ThemeProvider>(context, listen: false)
          .initializeProvider(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primary_300),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final ThemeProvider themeProvider =
                Provider.of<ThemeProvider>(context);

            ImageList.loadImage(context);

            SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.black,
              ),
            );

            return MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: Locale(themeProvider.getLanguage),
              routes: userProvider.currentUser != null
                  ? (userProvider.currentUser!.role == Role.student
                      ? StudentRoutes.routes
                      : CompanyRoutes.routes)
                  : AuthRoutes.routes,
              initialRoute: userProvider.currentUser != null
                  ? (userProvider.currentUser!.role == Role.student
                      ? StudentRoutes.nav
                      : CompanyRoutes.nav)
                  : AuthRoutes.login,
              debugShowCheckedModeBanner: false,
              theme: themeProvider.getThemeMode
                  ? AppTheme.darkTheme
                  : AppTheme.lightTheme,
            );
          }
        }
      },
    );
  }
}
