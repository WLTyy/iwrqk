import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwrqk/widgets/reloadable_image.dart';

import '../common/global.dart';
import '../common/theme.dart';
import '../pages/user_page/user_page.dart';
import '../component/tab_indicator.dart';

class AppBarX extends StatefulWidget {
  final bool? showFilter;
  final Map<String, Widget>? tabList;
  final Widget? body;
  final TabController? tabController;

  const AppBarX(
      {this.showFilter, this.tabList, this.body, this.tabController, Key? key})
      : super(key: key);

  @override
  State<AppBarX> createState() => _AppBarXState();
}

class _AppBarXState extends State<AppBarX> {
  Widget getTopTabbar(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          minWidth: 27.5.w,
          height: 40.w,
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const UserPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1, 0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ));
          },
          child: ClipOval(
              child: ReloadableImage(
            imageUrl:
                "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
            size: Size(35.w, 35.w),
          )),
        ),
        Expanded(
            child: SizedBox(
          height: 40.sp,
          child: CupertinoSearchTextField(
            prefixInsets: REdgeInsets.only(left: 10),
            prefixIcon: Icon(
              FluentIcons.search_12_regular,
              size: 20.sp,
            ),
            suffixInsets: REdgeInsets.only(right: 10),
            suffixIcon: Icon(
              FluentIcons.backspace_24_filled,
              size: 25.sp,
            ),
          ),
        )),
        MaterialButton(
            minWidth: 30.w,
            onPressed: () {
              Navigator.pushNamed(context, "/video");
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 2.5.h),
              child: Icon(
                FluentIcons.mail_48_regular,
                size: 35.sp,
                color: Colors.grey,
              ),
            )),
      ],
    );
  }

  PreferredSizeWidget? getBottomTabbar(bool? showFilter,
      Map<String, Widget>? tabList, TabController? tabController) {
    if (tabList != null) {
      return PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 50.h,
                      child: TabBar(
                        isScrollable: true,
                        indicator: const TabIndicator(),
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.blue,
                        tabs: getTab(tabList),
                        controller: tabController,
                      )),
                  Center(
                    child: Visibility(
                        visible: showFilter!,
                        child: SizedBox(
                          height: 50.h,
                          child: MaterialButton(
                              minWidth: 35.w,
                              onPressed: () {},
                              child: Icon(
                                FluentIcons.options_24_regular,
                                size: 27.5.sp,
                                color: Colors.grey,
                              )),
                        )),
                  ),
                ],
              )));
    } else {
      return null;
    }
  }

  List<Widget> getTab(Map<String, Widget>? tabList) {
    List<Widget> widgetList = [];
    tabList!.forEach((key, value) {
      widgetList.add(Tab(text: key));
    });
    return widgetList;
  }

  List<Widget> getTabWidget(Map<String, Widget> list) {
    return List<Widget>.from(list.keys.map((i) {
      return SafeArea(
          top: false,
          bottom: false,
          child: Builder(builder: (BuildContext context) {
            return CustomScrollView(
                physics: Platform.isAndroid
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(5.w),
                    sliver: SliverToBoxAdapter(child: list[i]),
                  )
                ]);
          }));
    }));
  }

  Widget getBodyWidget(Widget body) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Builder(builder: (BuildContext context) {
          return CustomScrollView(
              physics: Platform.isAndroid
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(5.w),
                  sliver: SliverToBoxAdapter(child: body),
                )
              ]);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                titleSpacing: 0,
                title: getTopTabbar(context),
                foregroundColor: Colors.black,
                floating: true,
                pinned: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                bottom: getBottomTabbar(
                    widget.showFilter, widget.tabList, widget.tabController),
              ),
            ),
          ];
        },
        body: widget.tabList == null
            ? getBodyWidget(widget.body!)
            : TabBarView(
                controller: widget.tabController,
                children: getTabWidget(widget.tabList!),
              ));
  }
}
