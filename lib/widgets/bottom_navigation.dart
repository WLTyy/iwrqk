import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iwrqk/common/theme.dart';
import 'package:iwrqk/l10n.dart';

import '../common/global.dart';
import '../pages/images_page.dart';
import '../pages/ranking_page/ranking_page.dart';
import '../pages/explore_page.dart';
import '../pages/videos_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _pageList = [];

  @override
  void initState() {
    _pageList
      ..add(const ExplorePage())
      ..add(const RankingPage())
      ..add(const VideosPage())
      ..add(const ImagesPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
        backgroundColor: IwrTheme.scaffoldBackColor,
        body: _pageList[_selectedIndex],
        extendBody: true,
        bottomNavigationBar: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: BottomNavigationBar(
                backgroundColor: IwrTheme.barBackColor,
                unselectedItemColor: IwrTheme.gray,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: const Icon(
                        Icons.rocket_launch_rounded,
                      ),
                      label: L10n.of(context).explore,
                      tooltip: ''),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.sort_rounded),
                      label: L10n.of(context).ranking,
                      tooltip: ''),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.smart_display_rounded),
                      label: L10n.of(context).videos,
                      tooltip: ''),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.image),
                      label: L10n.of(context).images,
                      tooltip: ''),
                ],
                currentIndex: _selectedIndex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.blue,
                onTap: ((index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }))));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Global.getOverlayStyle(),
      child: body,
    );
  }
}
