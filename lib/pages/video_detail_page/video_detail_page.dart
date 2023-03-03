import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../common/classes.dart';
import '../../component/iwr_tab_indicator.dart';
import '../../l10n.dart';
import '../../widgets/media_preview.dart';
import '../../widgets/reloadable_image.dart';
import 'iwr_video_play.dart';
import 'user_comment.dart';

class VideoDetailPage extends StatefulWidget {
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _iconTurn;
  late Animation<double> _heightFactor;
  List<MediaPreviewData> _data = <MediaPreviewData>[];
  List<UserComment> _cdata = [];
  bool _showDetail = true;
  late bool _detailExpanded;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _iconTurn = _animationController.drive(_halfTween.chain(_easeInTween));

    _heightFactor = _animationController.drive(_easeInTween);

    _detailExpanded =
        PageStorage.maybeOf(context)?.readState(context) as bool? ?? false;
    if (_detailExpanded) {
      _animationController.value = 1.0;
    }

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });

    var _test = MediaPreviewData();
    _test.coverImageUrl =
        "https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RE4wtcF?ver=6989";
    _test.likes = "114";
    _test.views = "114";
    _test.title = "嗡嗡嗡嗡嗡嗡1fAF2 - 123d1 p[wsda]哇哇哇哇哇哇哇哇哇哇";
    _test.type = MediaType.video;

    CommentData commentData = CommentData(
        UserData(
            "John Smith",
            'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
            'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png'),
        DateTime.now().toString(),
        "好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好好");

    commentData.replyTo = commentData.user;
    commentData.children.add(commentData);

    var _ctest = UserComment(commentData: commentData);

    for (var i = 0; i < 5; i++) {
      _data.add(_test);
      _cdata.add(_ctest);
    }

    super.initState();
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
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).cardColor, width: 1))),
                alignment: Alignment.centerLeft,
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
                )),
          ),
          Visibility(
              visible: _showDetail,
              child: Expanded(
                  child: TabBarView(controller: _tabController, children: [
                SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          border: Border(
                              bottom: BorderSide(
                                  color: Theme.of(context).cardColor,
                                  width: 1))),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: IconButton(
                                iconSize: 40,
                                icon: ClipOval(
                                  child: ReloadableImage(
                                    imageUrl:
                                        'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
                                    aspectRatio: 1,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/uploader_profile',
                                      arguments: UploaderProfile(
                                          'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
                                          'John Smith',
                                          'I love making videos!',
                                          '1919',
                                          '1week'));
                                },
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Futo",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DateTime.now().toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.5),
                                  ),
                                ],
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {},
                                child: Text(L10n.of(context).follow),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _detailExpanded = !_detailExpanded;

                                  if (_detailExpanded) {
                                    _animationController.forward();
                                  } else {
                                    _animationController
                                        .reverse()
                                        .then<void>((void value) {
                                      setState(() {
                                        // Rebuild without widget.children.
                                      });
                                    });
                                    ;
                                  }

                                  PageStorage.maybeOf(context)
                                      ?.writeState(context, _detailExpanded);
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '视频标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题',
                                      maxLines: _detailExpanded ? null : 1,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    alignment: Alignment.topRight,
                                    child: RotationTransition(
                                      turns: _iconTurn,
                                      child: Icon(CupertinoIcons.chevron_down),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.play_fill,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 2, right: 15),
                                      child: Text(
                                        "114",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      )),
                                  Icon(
                                    CupertinoIcons.hand_thumbsup_fill,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 2),
                                      child: Text(
                                        "114",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _animationController.view,
                              builder: (_, child) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  heightFactor: _heightFactor.value,
                                  child: child,
                                );
                              },
                              child: Offstage(
                                  offstage: !_detailExpanded &&
                                      _animationController.isDismissed,
                                  child: TickerMode(
                                      enabled: !(!_detailExpanded &&
                                          _animationController.isDismissed),
                                      child: Text('视频描述',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          )))),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: ButtonBar(
                                alignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                      child: Column(
                                        children: [
                                          Icon(
                                            CupertinoIcons.hand_thumbsup_fill,
                                            size: 35,
                                          ),
                                          Text(L10n.of(context).like,
                                              style: TextStyle(fontSize: 12.5))
                                        ],
                                      ),
                                      onPressed: () {}),
                                  MaterialButton(
                                      child: Column(
                                        children: [
                                          Icon(
                                            CupertinoIcons.list_bullet,
                                            size: 35,
                                          ),
                                          Text(L10n.of(context).playlists,
                                              style: TextStyle(fontSize: 12.5))
                                        ],
                                      ),
                                      onPressed: () {}),
                                  MaterialButton(
                                      child: Column(
                                        children: [
                                          Icon(
                                            CupertinoIcons
                                                .arrowshape_turn_up_right_fill,
                                            size: 35,
                                          ),
                                          Text(L10n.of(context).share,
                                              style: TextStyle(fontSize: 12.5))
                                        ],
                                      ),
                                      onPressed: () {}),
                                  MaterialButton(
                                      child: Column(
                                        children: [
                                          Icon(
                                            CupertinoIcons.arrow_down_to_line,
                                            size: 35,
                                          ),
                                          Text(L10n.of(context).download,
                                              style: TextStyle(fontSize: 12.5))
                                        ],
                                      ),
                                      onPressed: () {}),
                                ],
                              ),
                            )
                          ]),
                    ),
                    Container(
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "相似",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    WaterfallFlow.builder(
                      padding: EdgeInsets.all(8),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AspectRatio(
                          aspectRatio: 16 / 13.5,
                          child: MediaPreview(data: _data[index]),
                        );
                      },
                    ),
                    Container(
                      color: Theme.of(context).canvasColor,
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "相似",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    WaterfallFlow.builder(
                      padding: EdgeInsets.all(8),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AspectRatio(
                          aspectRatio: 16 / 13.5,
                          child: MediaPreview(data: _data[index]),
                        );
                      },
                    ),
                  ],
                )),
                Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            itemBuilder: (BuildContext context, int index) {
                              return _cdata[index];
                            },
                            itemCount: _cdata.length)),
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            border: Border(
                                top: BorderSide(
                                    color: Theme.of(context).cardColor,
                                    width: 1))),
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
