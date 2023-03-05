import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iwrqk/util.dart';
import 'package:video_player/video_player.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../common/classes.dart';
import '../../component/iwr_tab_indicator.dart';
import '../../l10n.dart';
import '../../network/spider.dart';
import '../../widgets/media_preview.dart';
import '../../widgets/reloadable_image.dart';
import 'iwr_video_play.dart';
import 'user_comment.dart';

class VideoDetailPage extends StatefulWidget {
  final String videoUrl;

  const VideoDetailPage({super.key, required this.videoUrl});

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
  bool _showDetail = true;
  late bool _detailExpanded;
  bool _isLoading = true;

  VideoData _videoData = VideoData();

  Future<void> _loadData() async {
    var videoData;
    await Spider.getVideoPage(widget.videoUrl).then((value) {
      videoData = value;
    });
    if (videoData != null) {
      setState(() {
        _videoData = videoData;
        _isLoading = false;
      });
    }
  }

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

    _loadData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
      body: Column(
        children: _isLoading
            ? [
                Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).viewPadding.top,
                ),
                Expanded(
                    child: Container(
                  color: Theme.of(context).canvasColor,
                  child: Center(
                      child: SizedBox(
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  )),
                ))
              ]
            : [
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
                                  color: Theme.of(context).cardColor,
                                  width: 1))),
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
                        child:
                            TabBarView(controller: _tabController, children: [
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
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    leading: GestureDetector(
                                      child: ClipOval(
                                        child: ReloadableImage(
                                          imageUrl:
                                              _videoData.uploader.avatarUrl,
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _videoData.uploader.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          _videoData.date,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.5),
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
                                            setState(() {});
                                          });
                                          ;
                                        }

                                        PageStorage.maybeOf(context)
                                            ?.writeState(
                                                context, _detailExpanded);
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _videoData.title,
                                            maxLines:
                                                _detailExpanded ? null : 1,
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
                                            child: Icon(
                                                CupertinoIcons.chevron_down),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.play_fill,
                                          size: 15,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                left: 2, right: 15),
                                            child: Text(
                                              _videoData.views,
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
                                              _videoData.likes ?? "0",
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
                                                _animationController
                                                    .isDismissed),
                                            child: RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                    children: <InlineSpan>[
                                                  parseHtmlCode(
                                                      _videoData.description)
                                                ])))),
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
                                                  CupertinoIcons
                                                      .hand_thumbsup_fill,
                                                  size: 35,
                                                ),
                                                Text(L10n.of(context).like,
                                                    style: TextStyle(
                                                        fontSize: 12.5))
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
                                                    style: TextStyle(
                                                        fontSize: 12.5))
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
                                                    style: TextStyle(
                                                        fontSize: 12.5))
                                              ],
                                            ),
                                            onPressed: () {}),
                                        MaterialButton(
                                            child: Column(
                                              children: [
                                                Icon(
                                                  CupertinoIcons
                                                      .arrow_down_to_line,
                                                  size: 35,
                                                ),
                                                Text(L10n.of(context).download,
                                                    style: TextStyle(
                                                        fontSize: 12.5))
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
                            padding: EdgeInsets.fromLTRB(20, 10, 10, 15),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              L10n.of(context).more_from_uploader,
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
                            itemCount: _videoData.moreFromUser.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AspectRatio(
                                aspectRatio: 16 / 15,
                                child: MediaPreview(
                                    data: _videoData.moreFromUser[index]),
                              );
                            },
                          ),
                          Container(
                            color: Theme.of(context).canvasColor,
                            padding: EdgeInsets.fromLTRB(20, 10, 10, 15),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              L10n.of(context).more_like_this,
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
                            itemCount: _videoData.moreLikeThis.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AspectRatio(
                                aspectRatio: 16 / 15,
                                child: MediaPreview(
                                    data: _videoData.moreLikeThis[index]),
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return UserComment(
                                        commentData:
                                            _videoData.comments[index]);
                                  },
                                  itemCount: _videoData.comments.length)),
                          Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).canvasColor,
                                  border: Border(
                                      top: BorderSide(
                                          color: Theme.of(context).cardColor,
                                          width: 1))),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(1000))),
                                child: Text(
                                  L10n.of(context).send_comment,
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
