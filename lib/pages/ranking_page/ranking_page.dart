import 'package:flutter/material.dart';
import 'package:iwrqk/l10n.dart';
import 'package:iwrqk/pages/ranking_page/ranking_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/global.dart';
import '../../common/theme.dart';
import '../../widgets/appbarx.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with SingleTickerProviderStateMixin {
  Map<int, List<String>> map = {
    0: [
      "田所浩",
      "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png"
    ],
    1: [
      "田所浩",
      "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png"
    ],
    2: [
      "田所浩",
      "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png"
    ],
    3: [
      "田所浩",
      "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png"
    ],
    4: [
      "田所浩",
      "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png"
    ],
    5: [
      "田所浩",
      "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png"
    ]
  };
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBarX(
      showFilter: false,
      tabList: {
        L10n.of(context).hottest: Container(
            color: IwrTheme.backColor,
            child: Column(
              children: [
                RankingCard(
                    title: L10n.of(context).hottest_character, itemMap: map),
                Container(
                  margin: REdgeInsets.symmetric(vertical: 25),
                  child: RankingCard(
                      title: L10n.of(context).hottest_uploader, itemMap: map),
                ),
                RankingCard(title: L10n.of(context).hottest_tag, itemMap: map),
                Container(
                  margin: REdgeInsets.only(top: 15, bottom: 75),
                  child: Text(
                    L10n.of(context).data_origin,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: IwrTheme.gray,
                    ),
                  ),
                )
              ],
            )),
        L10n.of(context).popular: Container(),
      },
      tabController: _tabController,
    );
  }
}
