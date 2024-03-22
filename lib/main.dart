import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:student_hub/utils/image_list.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => IndexPageProvider()),
        ChangeNotifierProvider(create: (_) => OpenIdProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => PostJobProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
              routes: AppRoutes.routes,
              initialRoute: '/',
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
