import 'package:flutter/material.dart';
import 'package:iwrqk/l10n.dart';

import '../pages/images_page.dart';
import '../pages/ranking_page.dart';
import '../pages/explore_page.dart';
import '../pages/videos_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  List<Widget> _pageList = [];

  @override
  void initState() {
    _pageList
      ..add(ExplorePage())
      ..add(RankingPage())
      ..add(VideosPage())
      ..add(ImagesPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: _pageList[_selectedIndex],
        bottomNavigationBar: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.rocket_launch_rounded),
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
  }
}
