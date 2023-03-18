import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:iwrqk/common/classes.dart';
import 'package:iwrqk/l10n.dart';
import 'package:iwrqk/pages/uploader_profile_page/uploader_profile_page.dart';

import '../../common/util.dart';
import '../../widgets/reloadable_image.dart';

class UserComment extends StatelessWidget {
  final CommentData commentData;

  const UserComment({Key? key, required this.commentData}) : super(key: key);

  Widget _buildUserWidget(BuildContext context) {
    return Row(
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
              pageBuilder: (context, animation, secondaryAnimation) =>
                  UploaderProfilePage(
                userName: commentData.user.userName,
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
    );
  }

  Widget _buildContentWithoutReplies(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 45),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Markdown(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                data: commentData.content),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              getDisplayTime(context, commentData.createDate),
              style: TextStyle(color: Colors.grey, fontSize: 12.5),
            ),
          ),
        ]));
  }

  Widget _repliesBuilder(BuildContext context, int index) {
    return Markdown(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        data:
            "[${commentData.children[index].user.nickName}](iwrqk://user/${commentData.children[index].user.userName})：${commentData.children[index].content}");
  }

  Widget _buildContentWithReplies(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Markdown(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  data: commentData.content),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                getDisplayTime(context, commentData.createDate),
                style: TextStyle(color: Colors.grey, fontSize: 12.5),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: commentData.repliesNum >= 2
                          ? 2
                          : commentData.repliesNum,
                      itemBuilder: _repliesBuilder),
                  Visibility(
                    visible: commentData.repliesNum > 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        L10n.of(context).comments_see_all_replies.replaceFirst(
                            "\$s", commentData.repliesNum.toString()),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

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
                      _buildUserWidget(context),
                      _buildContentWithoutReplies(context)
                    ]
                  : [
                      _buildUserWidget(context),
                      _buildContentWithReplies(context),
                    ],
            ),
          ),
        ],
      ),
    );
  }
}
