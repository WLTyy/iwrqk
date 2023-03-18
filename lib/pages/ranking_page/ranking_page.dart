import 'package:flutter/material.dart';

import '../../common/global.dart';
import '../../common/theme.dart';
import '../../l10n.dart';
import '../../widgets/iwr_appbar.dart';

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
    _tabController = TabController(length: 1, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IwrAppBar(
      showFilter: false,
      tabList: {
        L10n.of(context).sort_latest: Container(),
      },
      tabController: _tabController,
    );
  }
}
