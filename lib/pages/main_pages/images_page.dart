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
  FilterSetting _fliterSetting = FilterSetting(ratingType: RatingType.all);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IwrAppBar(
      showFilter: true,
      onFilterApplied: (rating, year, month) {
        setState(() {
          _fliterSetting =
              FilterSetting(ratingType: rating, year: year, month: month);
        });
      },
      lastFilterSetting: _fliterSetting,
      tabList: {
        L10n.of(context).sort_latest: MediaGridView(
          key: PageStorageKey<String>("images_page_latest"),
          sortSetting: SortSetting(
            sourceType: SourceType.images,
            orderType: OrderType.date,
          ),
          filterSetting: _fliterSetting,
        ),
        L10n.of(context).sort_trending: MediaGridView(
          key: PageStorageKey<String>("images_page_trending"),
          sortSetting: SortSetting(
            sourceType: SourceType.images,
            orderType: OrderType.trending,
          ),
          filterSetting: _fliterSetting,
        ),
        L10n.of(context).sort_popularity: MediaGridView(
          key: PageStorageKey<String>("images_page_popularity"),
          sortSetting: SortSetting(
            sourceType: SourceType.images,
            orderType: OrderType.popularity,
          ),
          filterSetting: _fliterSetting,
        ),
        L10n.of(context).sort_most_views: MediaGridView(
          key: PageStorageKey<String>("images_page_most_views"),
          sortSetting: SortSetting(
            sourceType: SourceType.images,
            orderType: OrderType.views,
          ),
          filterSetting: _fliterSetting,
        ),
        L10n.of(context).sort_most_likes: MediaGridView(
          key: PageStorageKey<String>("images_page_most_likes"),
          sortSetting: SortSetting(
            sourceType: SourceType.images,
            orderType: OrderType.likes,
          ),
          filterSetting: _fliterSetting,
        ),
      },
      tabController: _tabController,
    );
  }
}
