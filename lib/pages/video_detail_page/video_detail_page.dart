import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../common/classes.dart';
import '../../component/iwr_tab_indicator.dart';
import '../../l10n.dart';
import '../../widgets/reloadable_image.dart';
import 'iwr_video_play.dart';
import 'user_comment.dart';

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
                      Tab(text: L10n.of(context).details),
                      Tab(
                        text: L10n.of(context).comments,
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
                      ListTile(
                        contentPadding: EdgeInsets.all(5),
                        leading: IconButton(
                          iconSize: 35,
                          icon: ClipOval(
                            child: ReloadableImage(
                              imageUrl:
                                  'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
                              aspectRatio: 1,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/uploader_profile',
                                arguments: UploaderProfile(
                                    'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
                                    'John Smith',
                                    'I love making videos!',
                                    '1919',
                                    '1week'));
                          },
                        ),
                        title: Text(
                          "14",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {},
                          child: Text(L10n.of(context).follow),
                        ),
                      ),
                      Text(
                        '视频描述',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        UserComment(
                          avatarUrl:
                              'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
                          name: 'John Smith',
                          comment: 'This is a great app!',
                          likeCount: 10,
                          time: DateTime.now(),
                        )
                      ],
                    )),
                    Container(
                        color: Theme.of(context).canvasColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(1000))),
                          child: Text(
                            "test",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                  ],
                ),
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
