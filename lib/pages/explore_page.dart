import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iwrqk/l10n.dart';
import '../common/theme.dart';
import '../common/global.dart';

import '../widgets/appbarx.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
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
    return AppBarX(
      showFilter: false,
      tabList: {
        L10n.of(context).hottest: Container(),
        L10n.of(context).popular: Container(),
        L10n.of(context).latest: Container(),
        L10n.of(context).toplist: Container(),
      },
      tabController: _tabController,
    );
  }
}
