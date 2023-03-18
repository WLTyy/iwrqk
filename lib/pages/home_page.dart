import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/global.dart';
import '../l10n.dart';
import 'main_pages/images_page.dart';
import 'main_pages/explore_page.dart';
import 'main_pages/videos_page.dart';
import 'user_page/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pageList = [];

  @override
  void initState() {
    _pageList
      ..add(const ExplorePage())
      ..add(const VideosPage())
      ..add(const ImagesPage())
      ..add(const UserPage());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 15,
            unselectedFontSize: 13.5,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.bell, size: 30),
                  activeIcon: Icon(CupertinoIcons.bell_fill, size: 30),
                  label: L10n.of(context).browse_explore,
                  tooltip: ''),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.play_rectangle, size: 30),
                  activeIcon:
                      Icon(CupertinoIcons.play_rectangle_fill, size: 30),
                  label: L10n.of(context).browse_videos,
                  tooltip: ''),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.photo, size: 30),
                  activeIcon: Icon(CupertinoIcons.photo_fill, size: 30),
                  label: L10n.of(context).browse_images,
                  tooltip: ''),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person, size: 30),
                  activeIcon: Icon(CupertinoIcons.person_fill, size: 30),
                  label: L10n.of(context).browse_me,
                  tooltip: ''),
            ],
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: ((index) {
              setState(() {
                _selectedIndex = index;
              });
            })));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Global.getOverlayStyle(),
      child: body,
    );
  }
}
