import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/global.dart';
import '../common/theme.dart';
import '../l10n.dart';
import '../widgets/appbarx.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage>
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

  @override
  Widget build(BuildContext context) {
    return AppBarX(
      showFilter: true,
      tabList: {
        L10n.of(context).latest: Container(
            child: Column(
          children: [
            Text("1", style: TextStyle(fontSize: 50, color: Colors.white)),
          ],
        )),
        L10n.of(context).toplist: Container(
          child: Center(
              child: Text("2",
                  style: TextStyle(fontSize: 50, color: Colors.white))),
        ),
        L10n.of(context).popular: Container(
          child: Center(
              child: Text("3",
                  style: TextStyle(fontSize: 50, color: Colors.white))),
        ),
      },
      tabController: _tabController,
    );
  }
}
