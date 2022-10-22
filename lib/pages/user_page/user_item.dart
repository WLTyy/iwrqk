import 'package:flutter/material.dart';
import 'package:iwrqk/common/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, routeName);
                },
                child: Container(
                    padding: REdgeInsets.fromLTRB(0, 10, 0, 10),
                    width: 350.w,
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
                                  child: icon,
                                )),
                            Container(
                              margin: REdgeInsets.only(left: 10),
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: IwrTheme.fontColor3),
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: IwrTheme.fontColor3,
                          size: 20.sp,
                        ),
                      ],
                    )))));
  }
}
