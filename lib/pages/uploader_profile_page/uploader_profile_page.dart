import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/classes.dart';
import '../../common/util.dart';
import '../../component/iwr_tab_indicator.dart';
import '../../l10n.dart';
import '../../network/spider.dart';
import '../../widgets/reloadable_image.dart';
import '../main_pages/media_grid_view.dart';
import '../video_detail_page/user_comment.dart';

class UploaderProfilePage extends StatefulWidget {
  final String homePageUrl;

  const UploaderProfilePage({Key? key, required this.homePageUrl})
      : super(key: key);

  @override
  State<UploaderProfilePage> createState() => _UploaderProfilePageState();
}

class _UploaderProfilePageState extends State<UploaderProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _errorInfo;
  bool _isLoading = true;

  UploaderProfileData _profileData = UploaderProfileData();

  @override
  void initState() {
    _loadData();
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  Future<void> _loadData() async {
    var profileData;
    await Spider.getUploaderProfile(widget.homePageUrl).then((value) {
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

  Widget _buildUploderFunction() {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            ClipOval(
              child: ReloadableImage(
                imageUrl: _profileData.avatarUrl,
                width: 60,
                height: 60,
              ),
            ),
            SizedBox(height: 10),
            Text(
              _profileData.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(L10n.of(context).follow),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(L10n.of(context).friend),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(L10n.of(context).direct_message),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildUploaderDetailTab() {
    return SingleChildScrollView(
        child: Container(
      color: Theme.of(context).cardColor,
      child: Column(children: [
        if (_profileData.description != null)
          Card(
            margin: EdgeInsets.fromLTRB(15, 20, 15, 10),
            color: Theme.of(context).canvasColor,
            child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: RichText(
                    text: TextSpan(children: <InlineSpan>[
                  parseHtmlCode(_profileData.description!)
                ]))),
          ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                ListTile(
                  title: Text(L10n.of(context).join_date),
                  subtitle: Text(_profileData.joinDate),
                ),
                ListTile(
                  title: Text(L10n.of(context).last_active_time),
                  subtitle: Text(_profileData.lastLoginTime),
                ),
              ],
            )),
      ]),
    ));
  }

  Widget _buildTabBar() {
    return Container(
        color: Theme.of(context).canvasColor,
        alignment: Alignment.centerLeft,
        child: TabBar(
          isScrollable: true,
          indicator: IwrTabIndicator(),
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: [
            Tab(
              text: L10n.of(context).user_details,
            ),
            Tab(text: L10n.of(context).videos),
            Tab(
              text: L10n.of(context).images,
            ),
            Tab(
              text: L10n.of(context).comments,
            ),
          ],
          controller: _tabController,
        ));
  }

  Widget _buildVideosTab() {
    return MediaGridView(
      key: PageStorageKey<String>("uploader_videos"),
      sourceType: SourceType.uploader_videos,
      uploaderName: _profileData.name,
    );
  }

  Widget _buildImagesTab() {
    return MediaGridView(
      key: PageStorageKey<String>("uploader_images"),
      sourceType: SourceType.uploader_images,
      uploaderName: _profileData.name,
    );
  }

  Widget _buildCommentsTab() {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 1),
                itemBuilder: (BuildContext context, int index) {
                  return UserComment(commentData: _profileData.comments[index]);
                },
                itemCount: _profileData.comments.length)),
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
                              color: Colors.blue,
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
                _buildUploderFunction(),
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
