import 'package:flutter/material.dart';
import 'package:iwrqk/common/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/global.dart';

class UserItem extends StatefulWidget {
  final String title;
  final Icon icon;
  final String routeName;

  const UserItem(
      {required this.title,
      required this.icon,
      required this.routeName,
      Key? key})
      : super(key: key);
  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: ThemeData.dark().highlightColor,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: MaterialButton(
                minWidth: 340.w,
                onPressed: () {
                  Navigator.pushNamed(context, widget.routeName);
                },
                child: Container(
                    padding: REdgeInsets.fromLTRB(0, 10, 0, 10),
                    width: 340.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 30.w,
                                height: 35.h,
                                child: Center(
                                  child: widget.icon,
                                )),
                            Container(
                              margin: REdgeInsets.only(left: 10),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20.sp,
                        ),
                      ],
                    )))));
  }
}
