import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/common/util.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../common/classes.dart';
import '../../component/iwr_tab_indicator.dart';
import '../../l10n.dart';
import '../../network/api.dart';
import '../../widgets/Iwr_progress_indicator.dart';
import '../../widgets/media_preview.dart';
import '../../widgets/reloadable_image.dart';
import '../uploader_profile_page/uploader_profile_page.dart';
import 'iwr_gallery.dart';
import 'iwr_player/iwr_video_player.dart';
import 'user_comment.dart';

class MediaDetailPage extends StatefulWidget {
  final String id;
  final MediaType type;

  const MediaDetailPage({super.key, required this.id, required this.type});

  @override
  State<MediaDetailPage> createState() => _MediaDetailPageState();
}

class _MediaDetailPageState extends State<MediaDetailPage>
    with TickerProviderStateMixin {
  IwrVideoController? _iwrVideoController;
  PageController _iwrGalleryController = PageController(initialPage: 0);
  final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> _iconTurn;
  late Animation<double> _heightFactor;
  late bool _detailExpanded;
  bool _isLoading = true;
  String? _errorInfo;
  int _grallertLastPage = 0;

  MediaData _mediaData = MediaData();

  Future<void> _loadData() async {
    var mediaData;
    if (widget.type == MediaType.video) {
      await Api.getVideoPage(widget.id).then((value) {
        mediaData = value;
      });
    } else if (widget.type == MediaType.image) {
      await Api.getImagePage(widget.id).then((value) {
        mediaData = value;
      });
    }
    if (mediaData is VideoData) {
      _mediaData = mediaData;
      _iwrVideoController = IwrVideoController(
        availableResolutions: (_mediaData as VideoData).resolution,
        initResolutionindex: (_mediaData as VideoData).resolution.length - 1,
        callbackAfterInit: () {
          if (!mounted) return;
          setState(() {});
        },
      );
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    } else if (mediaData is ImageData) {
      _mediaData = mediaData;
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    } else if (mediaData is String) {
      if (!mounted) return;
      setState(() {
        _errorInfo = mediaData;
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
  void dispose() {
    //_iwrVideoController?.dispose();
    super.dispose();
  }

  Widget _buildLoadingWidget() {
    return Expanded(
        child: Center(
            child: _errorInfo == null
                ? IwrProgressIndicator()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _errorInfo = null;
                              _isLoading = true;
                            });
                            _loadData();
                          },
                          child: Center(
                            child: Icon(
                              CupertinoIcons.arrow_counterclockwise,
                              color: Theme.of(context).primaryColor,
                              size: 42,
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          _errorInfo!,
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  )));
  }

  Widget _buildPlayer() {
    return AspectRatio(
        aspectRatio: 16 / 9,
        child: !(_mediaData as VideoData).fetchFailed
            ? IwrVideoPlayer(
                controller: _iwrVideoController!,
              )
            : Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.xmark_circle_fill,
                          color: Colors.white,
                          size: 42,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "Failed to fetch videos",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ))
                  ],
                )));
  }

  Widget _buildGallery() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: IwrGallery(
        imageUrls: (_mediaData as ImageData).imageUrls,
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).cardColor, width: 1))),
      alignment: Alignment.centerLeft,
      child: TabBar(
        isScrollable: true,
        indicator: IwrTabIndicator(context),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Theme.of(context).primaryColor,
        tabs: [
          Tab(text: L10n.of(context).details),
          Tab(
            text: L10n.of(context).comments,
          )
        ],
        controller: _tabController,
      ),
    );
  }

  Widget _buildVideoDetail() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).cardColor, width: 1))),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildUploaderWidget(),
        _buildVideoTitle(),
        _buildLikesAndViews(),
        _buildVideoDescription(),
        _buildFunctionButtons()
      ]),
    );
  }

  Widget _buildUploaderWidget() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 5),
      leading: GestureDetector(
        child: ClipOval(
          child: ReloadableImage(
            imageUrl: _mediaData.uploader.avatarUrl,
            width: 40,
            height: 40,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                UploaderProfilePage(
              homePageUrl:
                  "https://www.iwara.tv/profile/${_mediaData.uploader.userName}",
            ),
          ));
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _mediaData.uploader.nickName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            getDisplayTime(context, _mediaData.createDate),
            style: TextStyle(color: Colors.grey, fontSize: 12.5),
          ),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {},
        child: Text(L10n.of(context).follow),
      ),
    );
  }

  Widget _buildVideoTitle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _detailExpanded = !_detailExpanded;

          if (_detailExpanded) {
            _animationController.forward();
          } else {
            _animationController.reverse().then<void>((void value) {
              setState(() {});
            });
          }

          PageStorage.maybeOf(context)?.writeState(context, _detailExpanded);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              _mediaData.title,
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
    );
  }

  Widget _buildLikesAndViews() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.eye_fill,
            size: 15,
            color: Colors.grey,
          ),
          Container(
              margin: EdgeInsets.only(left: 2, right: 15),
              child: Text(
                formatNumberWithCommas(context, _mediaData.views),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              )),
          Icon(
            CupertinoIcons.heart_fill,
            size: 15,
            color: Colors.grey,
          ),
          Container(
              margin: EdgeInsets.only(left: 2),
              child: Text(
                formatNumberWithCommas(context, _mediaData.likes),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildVideoDescription() {
    return AnimatedBuilder(
      animation: _animationController.view,
      builder: (_, child) {
        return Align(
          alignment: Alignment.centerLeft,
          heightFactor: _heightFactor.value,
          child: child,
        );
      },
      child: Offstage(
          offstage: !_detailExpanded && _animationController.isDismissed,
          child: TickerMode(
              enabled: !(!_detailExpanded && _animationController.isDismissed),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.grey),
                      children: <InlineSpan>[
                    parseHtmlCode(_mediaData.description)
                  ])))),
    );
  }

  Widget _buildFunctionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
              child: Column(
                children: [
                  Icon(
                    CupertinoIcons.heart_fill,
                    size: 35,
                  ),
                  Text(L10n.of(context).favorite,
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
                    CupertinoIcons.arrowshape_turn_up_right_fill,
                    size: 35,
                  ),
                  Text(L10n.of(context).share, style: TextStyle(fontSize: 12.5))
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
    );
  }

  Widget _buildDetailTab() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildVideoDetail(),
        if (_mediaData.moreFromUser.isNotEmpty)
          Container(
            color: Theme.of(context).canvasColor,
            padding: EdgeInsets.fromLTRB(20, 10, 10, 15),
            alignment: Alignment.centerLeft,
            child: Text(
              L10n.of(context).more_from_uploader,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        if (_mediaData.moreFromUser.isNotEmpty)
          WaterfallFlow.builder(
            padding: EdgeInsets.all(8),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _mediaData.moreFromUser.length,
            itemBuilder: (BuildContext context, int index) {
              return AspectRatio(
                aspectRatio: 16 / 15,
                child: MediaPreview(data: _mediaData.moreFromUser[index]),
              );
            },
          ),
        if (_mediaData.moreLikeThis.isNotEmpty)
          Container(
            color: Theme.of(context).canvasColor,
            padding: EdgeInsets.fromLTRB(20, 10, 10, 15),
            alignment: Alignment.centerLeft,
            child: Text(
              L10n.of(context).more_like_this,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        if (_mediaData.moreLikeThis.isNotEmpty)
          WaterfallFlow.builder(
            padding: EdgeInsets.all(8),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _mediaData.moreLikeThis.length,
            itemBuilder: (BuildContext context, int index) {
              return AspectRatio(
                aspectRatio: 16 / 15,
                child: MediaPreview(data: _mediaData.moreLikeThis[index]),
              );
            },
          ),
      ],
    ));
  }

  Widget _buildCommentsTab() {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 1),
                itemBuilder: (BuildContext context, int index) {
                  return UserComment(commentData: _mediaData.comments[index]);
                },
                itemCount: _mediaData.comments.length)),
        Container(
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                border: Border(
                    top: BorderSide(
                        color: Theme.of(context).cardColor, width: 1))),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(1000))),
              child: Text(
                L10n.of(context).send_comment,
                style: TextStyle(color: Colors.grey),
              ),
            )),
      ],
    );
  }

  String _getTitle(BuildContext context) {
    switch (widget.type) {
      case MediaType.video:
        return L10n.of(context).videos;
      case MediaType.image:
        return L10n.of(context).images;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body = Scaffold(
      body: Column(
        children: _isLoading
            ? [_buildLoadingWidget()]
            : [
                if (widget.type == MediaType.video) _buildPlayer(),
                if (widget.type == MediaType.image) _buildGallery(),
                _buildTabBar(),
                Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  _buildDetailTab(),
                  _buildCommentsTab(),
                ])),
              ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back, size: 30)),
        centerTitle: true,
        title: Text(_getTitle(context)),
      ),
      body: body,
    );
  }
}