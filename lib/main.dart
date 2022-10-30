import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';
import 'package:iwrqk/pages/video_page/video_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'pages/settings_page.dart';
import 'pages/user_page/user_page.dart';
import 'widgets/bottom_navigation.dart';
import 'common/theme.dart';
import 'common/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: ThemeModeProvider()),
              ],
              child: Consumer<ThemeModeProvider>(
                  builder: (context, themeModeProvider, _) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  theme: IwrTheme.getTheme(),
                  darkTheme: IwrTheme.getTheme(isDarkMode: true),
                  themeMode: themeModeProvider.themeMode,
                  initialRoute: '/',
                  routes: {
                    '/': (context) => const BottomNavigation(),
                    '/user': (context) => const UserPage(),
                    '/video': (context) => const VideoPage(),
                    '/settings': (context) => const SettingsPage(),
                  },
                );
              }));
        });
  }
}
