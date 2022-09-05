import 'package:flutter/material.dart';
import 'package:iwrqk/widgets/ranking_card.dart';

import '../widgets/appbarx.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              AppBarX(
                innerBoxIsScrolled: innerBoxIsScrolled,
              )
            ];
          },
          body: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Container(
                color: Colors.grey.shade200,
                child: Center(
                  child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          offset: Offset(5, 5),
                          blurRadius: 10,
                          color: Colors.grey,
                        )
                      ]),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 320,
                            width: 360,
                            color: Colors.white,
                            padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    child: Row(children: [
                                      Text(
                                        "Hottest Character",
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ]),
                                  ),
                                  Stack(alignment: Alignment.center, children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 220),
                                        child: RankingItem(
                                          name: "田所浩",
                                          imageScr:
                                              "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                                          rank: 3,
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(right: 220),
                                        child: RankingItem(
                                          name: "田所浩",
                                          imageScr:
                                              "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                                          rank: 2,
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 50),
                                        child: RankingItem(
                                          name: "田所浩",
                                          imageScr:
                                              "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                                          rank: 1,
                                        ))
                                  ]),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RankingItem(
                                        name: "田所浩",
                                        imageScr:
                                            "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                                        rank: 4,
                                      ),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: RankingItem(
                                            name: "田所浩",
                                            imageScr:
                                                "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                                            rank: 5,
                                          )),
                                      RankingItem(
                                        name: "田所浩",
                                        imageScr:
                                            "https://cravatar.cn/avatar/245467ef31b6f0addc72b039b94122a4.png",
                                        rank: 6,
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "More",
                                            style: TextStyle(
                                                fontSize: 17.5,
                                                color: Colors.grey),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 17.5,
                                            color: Colors.grey,
                                          )
                                        ]),
                                  )
                                ]),
                          ))),
                )),
          ),
        ));
  }
}
