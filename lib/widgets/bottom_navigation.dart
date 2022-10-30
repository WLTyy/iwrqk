import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iwrqk/common/theme.dart';
import 'package:iwrqk/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        body: _pageList[_selectedIndex],
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 15.sp,
            unselectedFontSize: 13.5.sp,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(FluentIcons.bookmark_16_regular, size: 30.sp),
                  activeIcon: Icon(FluentIcons.bookmark_16_filled, size: 30.sp),
                  label: L10n.of(context).explore,
                  tooltip: ''),
              BottomNavigationBarItem(
                  icon: Icon(FluentIcons.data_bar_vertical_16_regular,
                      size: 30.sp),
                  activeIcon: Icon(FluentIcons.data_bar_vertical_16_filled,
                      size: 30.sp),
                  label: L10n.of(context).ranking,
                  tooltip: ''),
              BottomNavigationBarItem(
                  icon: Icon(FluentIcons.video_16_regular, size: 30.sp),
                  activeIcon: Icon(FluentIcons.video_16_filled, size: 30.sp),
                  label: L10n.of(context).videos,
                  tooltip: ''),
              BottomNavigationBarItem(
                  icon: Icon(FluentIcons.image_16_regular, size: 30.sp),
                  activeIcon: Icon(FluentIcons.image_16_filled, size: 30.sp),
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
            })));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Global.getOverlayStyle(),
      child: body,
    );
  }
}
