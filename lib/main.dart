import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';

import 'pages/home_page.dart';
import 'common/global.dart';
import 'common/theme.dart';
import 'pages/settings_page.dart';
import 'pages/user_page/user_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ThemeModeProvider()),
        ],
        child: Consumer<ThemeModeProvider>(
            builder: (context, themeModeProvider, _) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'IwrQk',
            theme: IwrAppTheme.getTheme(),
            darkTheme: IwrAppTheme.getTheme(isDarkMode: true),
            themeMode: themeModeProvider.themeMode,
            initialRoute: '/',
            routes: {
              '/': (context) => const HomePage(),
              '/user': (context) => const UserPage(),
              '/settings': (context) => const SettingsPage(),
            },
          );
        }));
  }
}
