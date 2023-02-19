import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/reloadable_image.dart';

class UserComment extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String comment;
  final int likeCount;
  final DateTime time;

  const UserComment({
    Key? key,
    required this.avatarUrl,
    required this.name,
    required this.comment,
    required this.likeCount,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: ClipOval(
              child: ReloadableImage(
                imageUrl:
                    avatarUrl,
                aspectRatio: 1,
              ),
            ),
            onPressed: () {},
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      comment,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.hand_thumbsup_fill,
                          size: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 5),
                        Text(
                          likeCount.toString(),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      time.toString().split(".")[0],
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
