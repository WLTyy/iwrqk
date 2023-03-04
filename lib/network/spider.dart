import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';

import '../common/classes.dart';

class Spider {
  static Future<VideoData?> getVideoPage(String url) async {
    try {
      VideoData videoData = VideoData();
      Document document = Document();

      await Dio().get(url).then((value) {
        document = parse(value.data);
      });

      var uploaderDom =
          document.querySelector('div.node-info > div.submitted')!;
      var uploaderNameDom = uploaderDom.querySelector('a.username')!;
      var uploaderAvatarDom =
          uploaderDom.querySelector('div.user-picture > a > img')!;

      videoData.date = RegExp(
              "[1-9]\\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\\s+(20|21|22|23|[0-1]\\d):[0-5]\\d")
          .firstMatch(uploaderDom.innerHtml)!
          .group(0)!;

      videoData.title = uploaderDom.querySelector('h1.title')!.innerHtml;

      var uploader = UserData(
        uploaderNameDom.innerHtml,
        "https:${uploaderAvatarDom.attributes["src"]!}",
        uploaderNameDom.attributes["href"]!,
      );

      videoData.uploader = uploader;

      List<dynamic> resolution = <dynamic>[];

      await Dio()
          .get("https://www.iwara.tv/api/video/${url.split('/').last}")
          .then((value) {
        resolution = value.data;
      });

      for (var element in resolution) {
        videoData.resolution
            .addAll({element["resolution"]: "https:${element["uri"]}"});
      }

      videoData.description = document
          .querySelector('div.field-name-body > div > div > p')!
          .innerHtml;

      var likesAndViewsDom =
          document.querySelector('div.node-views')!.innerHtml;

      var likesAndViews = RegExp("(\\d+(\\.+\\d+|\\.{0})\\,{0,1})+")
          .allMatches(likesAndViewsDom)
          .toList();

      if (likesAndViews.length == 2) {
        videoData.views = likesAndViews[1].group(0)!;
        videoData.likes = likesAndViews[0].group(0)!;
      } else if (likesAndViews.length == 1) {
        videoData.views = likesAndViews[0].group(0)!;
      }

      var commentsDoms = document.querySelector("#comments");

      if (commentsDoms != null) {
        var comments = getComments(commentsDoms.children);

        for (var comment in comments) {
          if (comment.children.isNotEmpty) {
            var children = comment.preorderTraversal();
            comment.children =
                children.getRange(1, children.length - 1).toList();
          }
        }

        videoData.comments = comments;
      }

      var moreFromUserDom =
          document.querySelector('div.view-id-videos > div > div');

      videoData.moreFromUser =
          analyseMediaPreviewsHtml(moreFromUserDom!.innerHtml);

      var moreLikeThisDom =
          document.querySelector('div.view-id-search > div > div');

      videoData.moreLikeThis =
          analyseMediaPreviewsHtml(moreLikeThisDom!.innerHtml);

      return videoData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static List<MediaPreviewData> analyseMediaPreviewsHtml(String htmlCode) {
    var document = parse(htmlCode);
    List<MediaPreviewData> previewDatas = <MediaPreviewData>[];

    var previewDoms = document.querySelectorAll('div.node');

    for (var previewItem in previewDoms) {
      var previewData = MediaPreviewData();

      if (previewItem.className.contains("node-video")) {
        previewData.type = MediaType.video;
      } else if (previewItem.className.contains("node-image")) {
        previewData.type = MediaType.image;
      }

      if (previewItem.attributes.containsKey('data-original-title') |
          previewItem.attributes.containsKey('title')) {
        var titleDom = previewItem.querySelector('div > a')!;
        previewData.url = titleDom.attributes['href']!;
        if ((previewItem.attributes.containsKey('data-original-title'))) {
          previewData.title = previewItem.attributes['data-original-title']!;
        } else if ((previewItem.attributes.containsKey('title'))) {
          previewData.title = previewItem.attributes['title']!;
        }
      } else {
        var titleDom = previewItem.querySelector('h3.title > a')!;
        previewData.url = titleDom.attributes['href']!;
        previewData.title = titleDom.innerHtml;
      }

      var coverImageDom = previewItem.querySelector('img');
      previewData.coverImageUrl = coverImageDom == null
          ? null
          : "https:${coverImageDom.attributes['src']!}";

      var uploaderDom = previewItem.querySelector('a.username');
      if (uploaderDom != null) {
        previewData.uploaderName = uploaderDom.innerHtml;
        previewData.uploaderHomePageUrl = uploaderDom.attributes['href']!;
      }

      var viewsDom = previewItem.querySelector('div.left-icon.likes-icon')!;
      var likesDom = previewItem.querySelector('div.right-icon.likes-icon');
      var galleryIconDom =
          previewItem.querySelector('div.left-icon.multiple-icon');
      previewData.isGallery = galleryIconDom != null;

      previewData.views = viewsDom.text
          .replaceAll(' ', '')
          .replaceAll('\t', '')
          .replaceAll('\n', '');
      previewData.likes = likesDom == null
          ? "0"
          : likesDom.text
              .replaceAll(' ', '')
              .replaceAll('\t', '')
              .replaceAll('\n', '');

      previewDatas.add(previewData);
    }
    return previewDatas;
  }

  static List<CommentData> getComments(List<Element> commentsDoms,
      {UserData? replyTo, int depth = 0}) {
    List<CommentData> comments = <CommentData>[];
    CommentData? lastComment;

    for (var item in commentsDoms) {
      if (item.className.contains("comment")) {
        lastComment = analyseCommentHtml(item.innerHtml);
        lastComment.depth = depth;
        lastComment.replyTo = replyTo;
        comments.add(lastComment);
      } else if (item.className.contains("indented")) {
        comments.last.children = getComments(item.children,
            replyTo: lastComment!.user, depth: depth + 1);
      }
    }
    return comments;
  }

  static CommentData analyseCommentHtml(String htmlData) {
    var document = parse(htmlData);
    var userDom = document.querySelector('div.submitted')!;
    var userNameDom = userDom.querySelector('a.username')!;
    var userAvatarDom = document.querySelector('div.user-picture > a > img')!;
    var content =
        document.querySelector('div.content > div > div > div > p')!.innerHtml;

    var date = RegExp(
            "[1-9]\\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\\s+(20|21|22|23|[0-1]\\d):[0-5]\\d")
        .firstMatch(userDom.innerHtml)!
        .group(0)!;
    return CommentData(
        UserData(
            userNameDom.innerHtml,
            "https:${userAvatarDom.attributes['src']!}",
            userNameDom.attributes['href']!),
        date,
        content);
  }
}
