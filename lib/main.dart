import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/intl_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iwrqk/pages/video_page/video_page.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomNavigation(),
        '/user': (context) => const UserPage(),
        '/video': (context) => const VideoPage(),
      },
    );
  }
}
