import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/common/classes.dart';
import 'package:iwrqk/pages/search_page/search_page.dart';
import 'package:iwrqk/pages/uploader_profile_page/uploader_profile_page.dart';
import 'package:iwrqk/pages/video_detail_page/video_detail_page.dart';
import 'package:iwrqk/widgets/reloadable_image.dart';

import '../component/iwr_tab_indicator.dart';
import '../pages/user_page/user_page.dart';

class IwrAppBar extends StatefulWidget {
  final bool? showFilter;
  final Map<String, Widget> tabList;
  final TabController? tabController;

  const IwrAppBar(
      {Key? key, this.showFilter, required this.tabList, this.tabController})
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
                onPressed: () {
                  // Do something when filter button is pressed
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        iconSize: 35,
                        icon: ClipOval(
                          child: ReloadableImage(
                            imageUrl: 'https://picsum.photos/200/300',
                            aspectRatio: 1,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const UserPage(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                      ),
                      Expanded(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        SearchPage(),
                              ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 7.5, horizontal: 15),
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
                                      "Search",
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
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.5),
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.envelope,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
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
