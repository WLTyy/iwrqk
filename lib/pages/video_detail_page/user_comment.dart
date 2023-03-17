import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/common/classes.dart';
import 'package:iwrqk/pages/uploader_profile_page/uploader_profile_page.dart';

import '../../common/util.dart';
import '../../widgets/reloadable_image.dart';

class UserComment extends StatelessWidget {
  final CommentData commentData;

  const UserComment({Key? key, required this.commentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey _userNameKey = GlobalKey();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5),
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.fromLTRB(20, 15, 15, 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: commentData.children.isEmpty
                  ? [
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
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        UploaderProfilePage(
                                  homePageUrl: "https://www.iwara.tv/profile/${commentData.user.userName}",
                                ),
                              ));
                            },
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            commentData.user.nickName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 45),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: RichText(
                                      text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <InlineSpan>[
                                        parseHtmlCode(commentData.content)
                                      ])),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    commentData.date,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.5),
                                  ),
                                ),
                              ]))
                    ]
                  : [
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
                            commentData.user.nickName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 45),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: RichText(
                                    text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <InlineSpan>[
                                      parseHtmlCode(commentData.content)
                                    ])),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  commentData.date,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.5),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            commentData.children.length >= 2
                                                ? 2
                                                : commentData.children.length,
                                        itemBuilder: (context, index) {
                                          return RichText(
                                            text: TextSpan(
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: commentData
                                                            .children[index]
                                                            .depth ==
                                                        1
                                                    ? <InlineSpan>[
                                                        TextSpan(
                                                            text: commentData
                                                                .children[index]
                                                                .user
                                                                .nickName,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                        TextSpan(text: '：'),
                                                        parseHtmlCode(
                                                            commentData
                                                                .children[index]
                                                                .content)
                                                      ]
                                                    : <InlineSpan>[
                                                        TextSpan(
                                                            text: commentData
                                                                .children[index]
                                                                .user
                                                                .nickName,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                        TextSpan(text: '：'),
                                                        TextSpan(
                                                            text:
                                                                '@${commentData.children[index].replyTo!.nickName} ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue)),
                                                        parseHtmlCode(
                                                            commentData
                                                                .children[index]
                                                                .content)
                                                      ]),
                                          );
                                        }),
                                    Visibility(
                                      visible: commentData.children.length > 2,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Text(
                                          "See more",
                                          style: TextStyle(color: Theme.of(context).primaryColor),
                                        ),
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
