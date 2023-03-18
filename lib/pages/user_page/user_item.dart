import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            borderRadius: BorderRadius.circular(10),
            child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, widget.routeName);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 30,
                                height: 35,
                                child: Center(
                                  child: widget.icon,
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        Icon(
                          CupertinoIcons.forward,
                          size: 20,
                        ),
                      ],
                    )))));
  }
}
