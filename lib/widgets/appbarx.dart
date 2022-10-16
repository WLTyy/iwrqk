import 'package:flutter/material.dart';

import '../common/global.dart';
import '../common/theme.dart';
import '../pages/user_page/user_page.dart';
import '../component/tab_indicator.dart';

class AppBarX extends StatelessWidget {
  final bool innerBoxIsScrolled;
  final bool? showFilter;
  final List<String>? tabList;
  final TabController? tabController;

  const AppBarX(
      {required this.innerBoxIsScrolled,
      this.showFilter,
      this.tabList,
      this.tabController,
      Key? key})
      : super(key: key);

  PreferredSizeWidget? getTabbar(
      bool? showFilter, List<String>? tabList, TabController? tabController) {
    if (tabList != null) {
      return PreferredSize(
          preferredSize: const Size.fromHeight(37),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TabBar(
                    isScrollable: true,
                    indicator: const TabIndicator(),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: getTab(tabList),
                    controller: tabController,
                  ),
                  Visibility(
                    visible: showFilter!,
                    child: SizedBox(
                      height: 25,
                      child: MaterialButton(
                          minWidth: 25,
                          onPressed: () {},
                          child: Icon(
                            Icons.tune_rounded,
                            color: IwrTheme.gray,
                            size: 25,
                          )),
                    ),
                  ),
                ],
              )));
    } else {
      return null;
    }
  }

  List<Widget> getTab(List<String> tabList) {
    List<Widget> widgetList = [];
    for (String title in tabList) {
      widgetList.add(SizedBox(height: 35, child: Tab(text: title)));
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent),
      child: SliverAppBar(
        titleSpacing: 0,
        title: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  minWidth: 25,
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
                      child: Image.network(
                          "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover)),
                ),
                Expanded(
                    child: MaterialButton(
                  minWidth: 40,
                  height: 30,
                  focusColor: Colors.transparent,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: IwrTheme.gray,
                      width: 1.5,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.search_rounded,
                            size: 20,
                            color: Colors.blue,
                          )
                        ],
                      )),
                )),
                MaterialButton(
                    minWidth: 27.5,
                    onPressed: () {
                      Navigator.pushNamed(context, "/video");
                    },
                    child: Icon(
                      Icons.email_outlined,
                      color: IwrTheme.gray,
                      size: 27.5,
                    )),
              ],
            )),
        backgroundColor: IwrTheme.barBackColor,
        foregroundColor: Colors.black,
        pinned: true,
        floating: true,
        forceElevated: innerBoxIsScrolled,
        bottom: getTabbar(showFilter, tabList, tabController),
      ),
    );
  }
}
