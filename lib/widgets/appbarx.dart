import 'package:flutter/material.dart';

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
                          child: const Icon(
                            Icons.tune_rounded,
                            color: Colors.grey,
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
                  onPressed: () {},
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
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.all(
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
                    onPressed: () {},
                    child: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                      size: 27.5,
                    )),
              ],
            )),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        pinned: true,
        floating: true,
        forceElevated: innerBoxIsScrolled,
        bottom: getTabbar(showFilter, tabList, tabController),
      ),
    );
  }
}
