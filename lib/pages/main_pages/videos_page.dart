import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/classes.dart';
import '../../widgets/iwr_appbar.dart';
import '../../common/global.dart';
import '../../common/theme.dart';
import '../../l10n.dart';
import 'media_grid_view.dart';

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
    return IwrAppBar(
      showFilter: true,
      tabList: {
        L10n.of(context).latest: MediaGridView(
            sourceType: SourceType.videos,
            orderType: OrderType(SourceType.videos).date!),
        L10n.of(context).toplist: Container(
          child: MediaGridView(
            sourceType: SourceType.videos,
            orderType: OrderType(SourceType.videos).views!),
        ),
        L10n.of(context).popular: Container(
          child: MediaGridView(
            sourceType: SourceType.videos,
            orderType: OrderType(SourceType.videos).likes),
        ),
      },
      tabController: _tabController,
    );
  }
}
