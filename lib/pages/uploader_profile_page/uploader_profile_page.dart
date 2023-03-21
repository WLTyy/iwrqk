import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../common/classes.dart';
import '../../common/util.dart';
import '../../component/iwr_tab_indicator.dart';
import '../../l10n.dart';
import '../../network/api.dart';
import '../../widgets/reloadable_image.dart';
import '../main_pages/media_grid_view.dart';
import '../media_detail_page/user_comment.dart';

class UploaderProfilePage extends StatefulWidget {
  final String userName;

  const UploaderProfilePage({Key? key, required this.userName})
      : super(key: key);

  @override
  State<UploaderProfilePage> createState() => _UploaderProfilePageState();
}

class _UploaderProfilePageState extends State<UploaderProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String? _errorInfo;
  bool _isLoading = true;
  final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);
  late AnimationController _animationController;
  late Animation<double> _iconTurn;
  late Animation<double> _heightFactor;
  late bool _detailExpanded;

  UploaderProfileData _profileData = UploaderProfileData();

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

    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });

    _loadData();

    super.initState();
  }

  Future<void> _loadData() async {
    var profileData;
    await Api.getUploaderProfilePage(widget.userName).then((value) {
      profileData = value;
    });
    if (profileData is UploaderProfileData) {
      _profileData = profileData;
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    } else if (profileData is String) {
      if (!mounted) return;
      setState(() {
        _errorInfo = profileData;
      });
    }
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Stack(
          children: [
            ReloadableImage(
              imageUrl: _profileData.bannerUrl,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            _buildAvatarButton()
          ],
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Theme.of(context).canvasColor,
            child: Column(
              children: [
                _buildUploadName(),
                _buildDescription(),
                _buildJoinSeenAtDate()
              ],
            ))
      ],
    );
  }

  Widget _buildUploadName() {
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
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _profileData.uploader.nickName,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "@${_profileData.uploader.userName}",
                maxLines: 1,
                style: TextStyle(fontSize: 12.5),
              ),
            ],
          )),
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

  Widget _buildDescription() {
    final bool closed = !_detailExpanded && _animationController.isDismissed;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
          enabled: !closed,
          child: Markdown(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            data: _profileData.description,
          )),
    );

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: (_, child) {
        return ClipRect(
          child: Align(
            heightFactor: _heightFactor.value,
            child: child,
          ),
        );
      },
      child: closed ? null : result,
    );
  }

  Widget _buildJoinSeenAtDate() {
    Widget? lastActiveWidget;

    if (_profileData.lastActiveTime != null) {
      Duration difference =
          DateTime.now().difference(_profileData.lastActiveTime!);
      if (difference.inMinutes <= 5) {
        lastActiveWidget = Row(
          children: [
            Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
            Text(L10n.of(context).profile_online)
          ],
        );
      } else {
        lastActiveWidget = Text(
          "${L10n.of(context).profile_last_active_time}：${getDisplayDate(context, _profileData.lastActiveTime!)}",
          style: TextStyle(fontSize: 12.5),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "${L10n.of(context).profile_join_date}：${getDisplayDate(context, _profileData.joinDate)}",
          style: TextStyle(fontSize: 12.5),
        ),
        if (lastActiveWidget != null) lastActiveWidget
      ],
    );
  }

  Widget _buildAvatarButton() {
    return Container(
      margin: EdgeInsets.only(top: 150),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Theme.of(context).canvasColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 25),
            child: ClipOval(
              child: ReloadableImage(
                imageUrl: _profileData.uploader.avatarUrl,
                width: 60,
                height: 60,
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(compactBigNumber(context, _profileData.following),
                          style: TextStyle(fontSize: 12.5)),
                      Text(L10n.of(context).profile_following,
                          style: TextStyle(color: Colors.grey, fontSize: 12.5))
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(compactBigNumber(context, _profileData.followers),
                          style: TextStyle(fontSize: 12.5)),
                      Text(L10n.of(context).profile_followers,
                          style: TextStyle(color: Colors.grey, fontSize: 12.5))
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                      minimumSize: Size.fromHeight(0),
                      side: BorderSide(width: 2, color: Colors.blue),
                    ),
                    onPressed: () {},
                    child: Text(
                      L10n.of(context).profile_follow,
                    ),
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                        minimumSize: Size.zero,
                        side: BorderSide(width: 2, color: Colors.blue),
                      ),
                      onPressed: () {},
                      child: Text(L10n.of(context).profile_friend),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                      minimumSize: Size.zero,
                      side: BorderSide(width: 2, color: Colors.blue),
                    ),
                    onPressed: () {},
                    child: Text(L10n.of(context).profile_message),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildUploaderDetailTab() {
    return Container();
  }

  Widget _buildTabBar() {
    return Container(
        color: Theme.of(context).canvasColor,
        alignment: Alignment.centerLeft,
        child: TabBar(
          isScrollable: true,
          indicator: IwrTabIndicator(context),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: [
            Tab(
              text: L10n.of(context).user_user_details,
            ),
            Tab(text: L10n.of(context).browse_videos),
            Tab(
              text: L10n.of(context).browse_images,
            ),
            Tab(
              text: L10n.of(context).comments,
            ),
          ],
          controller: _tabController,
        ));
  }

  Widget _buildVideosTab() {
    return Container();
  }

  Widget _buildImagesTab() {
    return Container();
  }

  Widget _buildCommentsTab() {
    return Column(
      children: [],
    );
  }

  Widget _buildLoadingWidget() {
    return Expanded(
        child: Center(
            child: _errorInfo == null
                ? CircularProgressIndicator()
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back, size: 30)),
        centerTitle: true,
        title: Text(L10n.of(context).profile),
      ),
      body: Column(
        children: _isLoading
            ? [_buildLoadingWidget()]
            : [
                _buildHeader(),
                _buildTabBar(),
                Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  _buildUploaderDetailTab(),
                  _buildVideosTab(),
                  _buildImagesTab(),
                  _buildCommentsTab()
                ])),
              ],
      ),
    );
  }
}
