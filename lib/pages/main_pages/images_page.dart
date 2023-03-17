import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/classes.dart';
import '../../widgets/iwr_appbar.dart';
import '../../common/global.dart';
import '../../common/theme.dart';
import '../../l10n.dart';
import 'media_grid_view.dart';

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
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  Future<Null> _onRefresh() {
    return Future.delayed(Duration(seconds: 5), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return IwrAppBar(
      showFilter: true,
      tabList: {
        L10n.of(context).latest: MediaGridView(
          key: PageStorageKey<String>("videos_page_latest"),
          sortSetting: SortSetting(
              sourceType: SourceType.images,
              orderType: OrderType.date,
              ratingType: RatingType.all),
        ),
        L10n.of(context).trending: MediaGridView(
          key: PageStorageKey<String>("videos_page_trending"),
          sortSetting: SortSetting(
              sourceType: SourceType.images,
              orderType: OrderType.trending,
              ratingType: RatingType.all),
        ),
        L10n.of(context).popularity: MediaGridView(
          key: PageStorageKey<String>("videos_page_popularity"),
          sortSetting: SortSetting(
              sourceType: SourceType.images,
              orderType: OrderType.popularity,
              ratingType: RatingType.all),
        ),
        L10n.of(context).most_views: MediaGridView(
          key: PageStorageKey<String>("videos_page_most_views"),
          sortSetting: SortSetting(
              sourceType: SourceType.images,
              orderType: OrderType.views,
              ratingType: RatingType.all),
        ),
        L10n.of(context).most_likes: MediaGridView(
          key: PageStorageKey<String>("videos_page_most_likes"),
          sortSetting: SortSetting(
              sourceType: SourceType.images,
              orderType: OrderType.likes,
              ratingType: RatingType.all),
        ),
      },
      tabController: _tabController,
    );
  }
}
