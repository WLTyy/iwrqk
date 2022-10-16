import 'package:flutter/material.dart';
import 'package:iwrqk/common/theme.dart';

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
        child: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, routeName);
            },
            child: Container(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                width: 360,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: 30,
                            height: 35,
                            child: Center(
                              child: icon,
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 20, color: IwrTheme.fontColor2),
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: IwrTheme.fontColor2,
                    ),
                  ],
                ))));
  }
}
