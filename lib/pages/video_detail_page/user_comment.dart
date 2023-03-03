import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/common/classes.dart';

import '../../widgets/reloadable_image.dart';

class UserComment extends StatelessWidget {
  final CommentData commentData;

  const UserComment({Key? key, required this.commentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey _userNameKey = GlobalKey();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: ClipOval(
                        child: ReloadableImage(
                          imageUrl: commentData.user.avatarUrl,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      commentData.user.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(left: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commentData.content,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            commentData.date,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.5),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(5)),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text: '某个人',
                                          style: TextStyle(color: Colors.grey)),
                                      TextSpan(text: ': '),
                                      TextSpan(text: 'LOLOLOLOL'),
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "See more",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
