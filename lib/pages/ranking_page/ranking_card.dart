import 'package:flutter/material.dart';
import 'package:iwrqk/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iwrqk/widgets/reloadable_image.dart';

import '../../common/global.dart';
import '../../common/theme.dart';

class RankingCard extends StatelessWidget {
  final String title;
  final Map<int, List<String>> itemMap;

  const RankingCard({required this.title, required this.itemMap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(5.r, 5.r),
            blurRadius: 10.r,
          )
        ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              height: 340.h,
              width: 360.w,
              padding: REdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: REdgeInsets.only(bottom: 15),
                      child: Row(children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 25.sp,
                          ),
                        )
                      ]),
                    ),
                    Container(
                        margin: REdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RankingItem(
                              name: itemMap[2]![0],
                              imageScr: itemMap[2]![1],
                              rank: 2,
                            ),
                            Container(
                                margin: REdgeInsets.fromLTRB(10, 0, 10, 35),
                                child: RankingItem(
                                  name: itemMap[1]![0],
                                  imageScr: itemMap[1]![1],
                                  rank: 1,
                                )),
                            RankingItem(
                              name: itemMap[3]![0],
                              imageScr: itemMap[3]![1],
                              rank: 3,
                            )
                          ],
                        )),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RankingItem(
                          name: itemMap[3]![0],
                          imageScr: itemMap[3]![1],
                          rank: 4,
                        ),
                        Container(
                            margin: REdgeInsets.symmetric(horizontal: 10),
                            child: RankingItem(
                              name: itemMap[4]![0],
                              imageScr: itemMap[4]![1],
                              rank: 5,
                            )),
                        RankingItem(
                          name: itemMap[5]![0],
                          imageScr: itemMap[5]![1],
                          rank: 6,
                        )
                      ],
                    ),
                    Expanded(
                        child: Center(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                          Text(
                            L10n.of(context).more,
                            style: TextStyle(
                              fontSize: 17.5.sp,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 17.5.sp,
                          )
                        ])))
                  ]),
            )));
  }
}

class RankingItem extends StatelessWidget {
  final String name;
  final String imageScr;
  final int rank;

  const RankingItem(
      {required this.name,
      required this.imageScr,
      required this.rank,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [Colors.grey, Colors.grey.shade600];
    if (rank == 1) {
      colors = [Colors.yellowAccent, Colors.yellow.shade800];
    } else if (rank == 2) {
      colors = [Colors.lightBlue.shade50, Colors.lightBlue.shade300];
    } else if (rank == 3) {
      colors = [Colors.orange.shade100, Colors.deepOrange.shade300];
    }

    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(3.r, 3.r),
              blurRadius: 10.r,
            )
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5.r),
            child: Stack(
              children: [
                Container(
                  width: 100.w,
                  height: 85.h,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 2.5.sp),
                            child: ClipOval(
                                child: ReloadableImage(
                              imageUrl: imageScr,
                              size: Size(35.w, 35.w),
                            ))),
                        Expanded(
                          child: Center(
                              child: Text(name,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ))),
                        ),
                      ]),
                ),
                ClipPath(
                    clipper: BackgroundClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: colors,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.r))),
                      width: 45,
                      height: 30,
                      child: Container(
                          margin: REdgeInsets.only(left: 7.5, top: 5),
                          child: Text(rank.toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1.5.r, 1.5.r),
                                    blurRadius: 5.r,
                                    color: Colors.grey,
                                  )
                                ],
                              ))),
                    ))
              ],
            )));
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height.h);
    path.lineTo(size.width.w - 27.5.w, size.height.h);
    path.quadraticBezierTo(size.width.w - 20.w, size.height.h,
        size.width.w - 20.w, size.height.h - 5.h);
    path.quadraticBezierTo(size.width.w - 12.5.w, 0, size.width.w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
