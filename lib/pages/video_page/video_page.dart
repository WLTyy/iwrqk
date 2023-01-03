import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../component/tab_indicator.dart';
import '../../l10n.dart';
import '../../widgets/reloadable_image.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
      body: Column(children: [
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).viewPadding.top,
        ),
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
        ),
        Container(
            color: Theme.of(context).canvasColor,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  height: 45.h,
                  child: TabBar(
                    isScrollable: true,
                    indicator: const TabIndicator(),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: "Details"),
                      Tab(
                        text: "Comments",
                      )
                    ],
                    controller: _tabController,
                  ))
            ])),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    color: Theme.of(context).canvasColor,
                    child: Container(
                        margin: REdgeInsets.only(left: 10, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MaterialButton(
                                  minWidth: 0,
                                  height: 40.w,
                                  onPressed: () {},
                                  child: ClipOval(
                                      child: ReloadableImage(
                                    imageUrl:
                                        "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                                    size: Size(35.w, 35.w),
                                  )),
                                ),
                                Text(
                                  "uper",
                                  style: TextStyle(fontSize: 20.h),
                                )
                              ],
                            ),
                            Theme(
                                data: Theme.of(context).copyWith(
                                  splashColor: Colors.blue,
                                  shadowColor: Colors.transparent,
                                ),
                                child: MaterialButton(
                                  minWidth: 0,
                                  height: 30.w,
                                  onPressed: () {},
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: Text(
                                    "Subscribe",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.sp),
                                  ),
                                )),
                          ],
                        ))),
              ],
            ),
            Container(),
          ]),
        ),
      ]),
    );

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
