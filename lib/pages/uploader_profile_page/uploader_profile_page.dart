import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/classes.dart';
import '../../component/iwr_tab_indicator.dart';
import '../../l10n.dart';
import '../../widgets/reloadable_image.dart';

class UploaderProfilePage extends StatefulWidget {
  const UploaderProfilePage({Key? key}) : super(key: key);

  @override
  State<UploaderProfilePage> createState() => _UploaderProfilePageState();
}

class _UploaderProfilePageState extends State<UploaderProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final uploaderProfile =
        ModalRoute.of(context)!.settings.arguments as UploaderProfile;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back, size: 30)),
        title: Text('个人主页'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).canvasColor,
            padding: EdgeInsets.only(top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  ClipOval(
                    child: ReloadableImage(
                      imageUrl:
                          'https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    uploaderProfile.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('关注'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('加好友'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('私信'),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
              color: Theme.of(context).canvasColor,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                    child: TabBar(
                  isScrollable: true,
                  indicator: IwrTabIndicator(),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(text: L10n.of(context).videos)
                    ,
                    Tab(
                      text: L10n.of(context).images,
                    )
                    ,
                    Tab(
                      text: L10n.of(context).comments,
                    ),
                    Tab(
                      text: L10n.of(context).user_details,
                    )
                  ],
                  controller: _tabController,
                ))
              ])),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 16 / 9,
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      'Video $index',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
            Container(),
            Container(),
            Container()
          ])),
        ],
      ),
    );
  }
}
