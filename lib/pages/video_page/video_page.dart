import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(children: [
          Container(
            height: 50,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black45,
              Colors.black26,
              Colors.black12,
              Colors.transparent
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Container(
            height: 75,
          ),
          Container(
            height: 50,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.transparent,
              Colors.black12,
              Colors.black26,
              Colors.black45
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          )
        ])));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: body,
    );
  }
}
