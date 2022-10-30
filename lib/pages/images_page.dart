import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwrqk/widgets/video_preview.dart';

import '../common/global.dart';
import '../common/theme.dart';
import '../l10n.dart';
import '../widgets/appbarx.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  Future<Null> _onRefresh() {
    return Future.delayed(Duration(seconds: 5), () {
      // 延迟5s完成刷新
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return AppBarX(
      showFilter: true,
      tabList: {
        L10n.of(context).latest: RefreshIndicator(
          onRefresh: _onRefresh,
          displacement: 15.h,
          color: Colors.blue,
          backgroundColor: Colors.transparent,
          notificationPredicate: defaultScrollNotificationPredicate,
          child: GridView.builder(
              padding: REdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: 10,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                childAspectRatio: (mediaQuery.size.width - 40.h) / 2 / 190.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: VideoPreview(
                    duration: "1:14",
                    title: "我1是i你1爹操是吧乐乐乐了额呜呜了；额",
                    imageSrc:
                        "https://ts4.cn.mm.bing.net/th?id=OVF.XNMdBsSCDdyBZU9Xkh%2b7GQ&w=257&h=144&c=7&rs=1&qlt=90&o=5&dpr=2&pid=2.1",
                    likes: "114",
                    plays: "114",
                    uploaderName: '乐子人',
                  ),
                );
              }),
        ),
        L10n.of(context).toplist: Container(),
        L10n.of(context).popular: Container(),
      },
      tabController: _tabController,
    );
  }
}
