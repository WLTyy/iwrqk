import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../component/iwr_tab_indicator.dart';
import 'iwr_video_play.dart';

class VideoDetailPage extends StatefulWidget {
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showDetail = true;

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
      body: Column(
        children: [
          Container(
            color: Colors.black,
            height: MediaQuery.of(context).viewPadding.top,
          ),
          IwrVideoPlayer(
            videoUrl:
                "https://vdse.bdstatic.com//192d9a98d782d9c74c96f09db9378d93.mp4",
            fullScreenCallback: () {
              _showDetail = !_showDetail;
            },
          ),
          Visibility(
            visible: _showDetail,
            child: Container(
                color: Theme.of(context).canvasColor,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                      child: TabBar(
                    isScrollable: true,
                    indicator: IwrTabIndicator(),
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
          ),
          Visibility(
              visible: _showDetail,
              child: Expanded(
                  child: TabBarView(controller: _tabController, children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '视频标题',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '视频描述',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        '评论区',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '暂无评论',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(),
              ]))),
        ],
      ),
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
