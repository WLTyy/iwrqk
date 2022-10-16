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
    return NestedScrollView(
        body: Center(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            AppBarX(
              innerBoxIsScrolled: innerBoxIsScrolled,
              showFilter: false,
              tabList: [
                L10n.of(context).hottest,
                L10n.of(context).popular,
                L10n.of(context).latest,
                L10n.of(context).toplist,
              ],
              tabController: _tabController,
            )
          ];
        });
  }
}
