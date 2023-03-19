import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/common/classes.dart';
import 'package:iwrqk/l10n.dart';
import 'package:iwrqk/pages/search_page/search_page.dart';

import '../component/iwr_tab_indicator.dart';
import 'filter_dialog.dart';

class IwrAppBar extends StatefulWidget {
  final bool? showFilter;
  final Map<String, Widget> tabList;
  final TabController? tabController;
  final void Function(String? rating, int? year, int? month)? onFilterApplied;
  final FilterSetting? lastFilterSetting;

  const IwrAppBar(
      {Key? key,
      this.showFilter,
      required this.tabList,
      this.tabController,
      this.onFilterApplied,
      this.lastFilterSetting})
      : super(key: key);

  @override
  State<IwrAppBar> createState() => _IwrAppBarState();
}

class _IwrAppBarState extends State<IwrAppBar> {
  PreferredSize? _buildBottomWidget(bool? showFilter,
      Map<String, Widget>? tabList, TabController? tabController) {
    if (tabList != null) {
      return PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight), // Add extra height for filter button
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                isScrollable: true,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                controller: widget.tabController,
                indicator: IwrTabIndicator(context),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: _buildTab(tabList),
              ),
            ),
            Visibility(
              visible: widget.showFilter!,
              child: IconButton(
                icon: Icon(CupertinoIcons.slider_horizontal_3),
                color: Colors.grey,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterDialog(
                        onFilterApplied: widget.onFilterApplied!,
                        lastFilterSetting: widget.lastFilterSetting,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      );
    } else {
      return null;
    }
  }

  List<Widget> _buildTab(Map<String, Widget>? tabList) {
    List<Widget> widgetList = [];
    tabList!.forEach((key, value) {
      widgetList.add(Tab(text: key));
    });
    return widgetList;
  }

  List<Widget> _buildTabWidget(Map<String, Widget> list) {
    return List<Widget>.from(list.keys.map((i) {
      return list[i]!;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                titleSpacing: 0,
                expandedHeight: 100,
                floating: true,
                pinned: true,
                snap: true,
                title: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 1,
                  title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  SearchPage(),
                        ));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        padding:
                            EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.search,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                L10n.of(context).search,
                                style: TextStyle(
                                    fontSize: 17.5,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                bottom: _buildBottomWidget(
                    widget.showFilter, widget.tabList, widget.tabController)),
          ];
        },
        body: TabBarView(
            controller: widget.tabController,
            children: _buildTabWidget(widget.tabList)));
  }
}
