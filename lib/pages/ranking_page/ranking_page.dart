import 'package:flutter/material.dart';
import 'package:iwrqk/l10n.dart';
import 'package:iwrqk/pages/ranking_page/ranking_card.dart';

import '../../common/global.dart';
import '../../common/theme.dart';
import '../../widgets/appbarx.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
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
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          AppBarX(
            innerBoxIsScrolled: innerBoxIsScrolled,
          )
        ];
      },
      body: Container(
          color: IwrTheme.scaffoldBackColor,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 15),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    RankingCard(
                        title: L10n.of(context).hottest_character,
                        itemMap: map),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      child: RankingCard(
                          title: L10n.of(context).hottest_uploader,
                          itemMap: map),
                    ),
                    RankingCard(
                        title: L10n.of(context).hottest_tag, itemMap: map),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        L10n.of(context).data_origin,
                        style: TextStyle(
                          fontSize: 15,
                          color: IwrTheme.gray,
                        ),
                      ),
                    )
                  ],
                );
              })),
    );
  }
}
