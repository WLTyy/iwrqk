
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart';
import 'package:html_unescape/html_unescape.dart';

import '../common/classes.dart';

class Api {
  static Future<Object> getUploaderProfile(String url) async {
    try {
      UploaderProfileData profileData = UploaderProfileData();
      Document document = Document();

      await Dio().get(url).then((value) {
        document = parse(value.data);
      });

      var infoDom = document.querySelector('div.view-profile > div > div')!;

      profileData.avatarUrl =
          "http:${infoDom.querySelector('img')!.attributes['src']!}";
      profileData.name = infoDom.querySelector('h2')!.innerHtml;
      profileData.joinDate = infoDom
          .querySelector('div.views-field-created > span.field-content')!
          .text;
      profileData.lastLoginTime = infoDom.querySelector('em')!.innerHtml;

      var discriptionDom =
          infoDom.querySelector('div.views-field-field-about > div');
      profileData.description = discriptionDom?.innerHtml;

      var uploadedVideosDom =
          document.querySelector('div.view-videos > div.view-content');

      profileData.moreUploadedVideos =
          document.querySelector('div.view-videos > div.more-link') != null;

      if (uploadedVideosDom != null) {
      }

      var uploadedImagesDom =
          document.querySelector('div.view-images > div.view-content');

      profileData.moreUploadedImages =
          document.querySelector('div.view-images > div.more-link') != null;

      if (uploadedImagesDom != null) {
      }

      var commentsDoms = document.querySelector("#comments");

      if (commentsDoms != null) {
        var comments = getComments(commentsDoms.children);

        for (var comment in comments) {
          if (comment.children.isNotEmpty) {
            var children = comment.preorderTraversal();
            comment.children = children.getRange(1, children.length).toList();
          }
        }

        profileData.comments = comments;
      }

      return profileData;
    } catch (e, stackTrace) {
      return "${e}";
    }
  }

  static Future<Object> getVideoPage(String url) async {
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

      videoData.title = HtmlUnescape()
          .convert(uploaderDom.querySelector('h1.title')!.innerHtml);

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

      var processingVideo = document.querySelector("#video-processing");

      if (processingVideo != null && resolution.isEmpty) {
        videoData.processingVideo = processingVideo.text;
      }

      var description =
          document.querySelector('div.field-name-body > div > div > p');

      videoData.description = description != null ? description.innerHtml : "";

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
            comment.children = children.getRange(1, children.length).toList();
          }
        }

        videoData.comments = comments;
      }

      var moreFromUserDom =
          document.querySelector('div.view-id-videos > div > div');


      var moreLikeThisDom =
          document.querySelector('div.view-id-search > div > div');

      return videoData;
    } catch (e, stackTrace) {
      return "${e}";
    }
  }

  static List<MediaPreviewData> analyseMediaPreviewsJson(dynamic previews) {
  List<MediaPreviewData> previewDatasList = [];

  for (var previewItem in previews["results"]) {
    MediaPreviewData previewData = MediaPreviewData();
    previewData.id = previewItem["id"];

    previewData.title = previewItem["title"];
    previewData.ratingType = previewItem["rating"];
    if (previewItem["files"] != null) {
      previewData.type = MediaType.image;
      previewData.thumbnailUrl =
          "/image/avatar/${previewItem["thumbnail"]["id"]}/${previewItem["thumbnail"]["name"]}";
    } else {
      previewData.type = MediaType.video;
      previewData.duration = previewItem["file"]["duration"];
      previewData.fileId = previewItem["file"]["id"];
      previewData.thumbnailLength = previewItem["file"]["numThumbnails"];
    }
    previewData.likes = previewItem["numLikes"];
    previewData.views = previewItem["numViews"];

    var uploader = previewItem["user"];

    var avatarUrl = uploader["avatar"] == null
        ? "/images/default-avatar.jpg"
        : "/image/avatar/${uploader["avatar"]["id"]}/${uploader["avatar"]["name"]}";

    previewData.uploader =
        UserData(uploader["username"], uploader["name"], avatarUrl);

    previewData.galleryLength = previewItem["numImages"];

    previewData.date = DateTime.parse(previewItem["updatedAt"]);
    if (previewItem.containsKey("private")) {
      previewData.isPrivate = previewItem["private"];
    }

    previewDatasList.add(previewData);
  }
  return previewDatasList;
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
