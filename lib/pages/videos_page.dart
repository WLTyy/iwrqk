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
    return NestedScrollView(
      body: Center(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          AppBarX(
            innerBoxIsScrolled: innerBoxIsScrolled,
            showFilter: true,
            tabList: [
              L10n.of(context).latest,
              L10n.of(context).toplist,
              L10n.of(context).popular
            ],
            tabController: _tabController,
          )
        ];
      },
    );
  }
}
