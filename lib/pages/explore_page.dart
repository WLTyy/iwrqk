import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/iwr_appbar.dart';
import '../common/theme.dart';
import '../common/global.dart';
import '../l10n.dart';
import '../widgets/reloadable_image.dart';

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
    return IwrAppBar(
      showFilter: false,
      tabList: {
        L10n.of(context).hottest: Container(
          child: Center(
            child: ReloadableImage(imageUrl: 'https://picsum.photos/200/300'),
          ),
        ),
        L10n.of(context).popular: Container(),
        L10n.of(context).latest: Container(),
        L10n.of(context).toplist: Container(),
      },
      tabController: _tabController,
    );
  }
}
