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
          key: PageStorageKey<String>("videos_page_latest"),
          sortSetting: SortSetting(
              sourceType: SourceType.videos,
              orderType: OrderType.date,
              ratingType: RatingType.all),
        ),
        L10n.of(context).toplist: MediaGridView(
            key: PageStorageKey<String>("videos_page_toplist"),
            sortSetting: SortSetting(
                sourceType: SourceType.videos,
                orderType: OrderType.views,
                ratingType: RatingType.all)),
        L10n.of(context).popular: MediaGridView(
            key: PageStorageKey<String>("videos_page_popular"),
            sortSetting: SortSetting(
                sourceType: SourceType.videos,
                orderType: OrderType.likes,
                ratingType: RatingType.all)),
      },
      tabController: _tabController,
    );
  }
}
