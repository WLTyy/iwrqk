import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import '../common/classes.dart';

class Api {
  static const salt = "_5nFp9kmbNnHdAFhaqMvt";

  static List<MediaPreviewData> analyseMediaPreviewsJson(dynamic previews) {
    List<MediaPreviewData> previewDatasList = [];

    for (var previewItem in previews["results"]) {
      MediaPreviewData previewData = MediaPreviewData();

      previewData.id = previewItem["id"];
      previewData.title = previewItem["title"];
      previewData.ratingType = previewItem["rating"];
      previewData.likes = previewItem["numLikes"];
      previewData.views = previewItem["numViews"];

      if (previewItem["numImages"] != null) {
        previewData.type = MediaType.image;
      } else {
        previewData.type = MediaType.video;
      }

      if (previewItem["thumbnail"] is! int) {
        previewData.thumbnailUrl =
            "/image/thumbnail/${previewItem["thumbnail"]["id"]}/${previewItem["thumbnail"]["name"]}";
      }

      if (previewItem["file"] != null) {
        previewData.duration = previewItem["file"]["duration"];
        previewData.fileId = previewItem["file"]["id"];
        previewData.thumbnailLength = previewItem["file"]["numThumbnails"];
      }

      if (previewItem["embedUrl"] != null) {
        previewData.youtubeUrl = previewItem["embedUrl"];
        var youtubeId = Uri.parse(previewItem["embedUrl"]).pathSegments.first;
        previewData.thumbnailUrl = "/image/embed/thumbnail/youtube/$youtubeId";
      }

      var uploader = previewItem["user"];

      var avatarUrl = uploader["avatar"] == null
          ? "/images/default-avatar.jpg"
          : "/image/avatar/${uploader["avatar"]["id"]}/${uploader["avatar"]["name"]}";

      previewData.uploader = UserData(
          id: uploader["id"],
          userName: uploader["username"],
          nickName: uploader["name"],
          avatarUrl: avatarUrl);

      previewData.galleryLength = previewItem["numImages"];

      previewData.createDate = DateTime.parse(previewItem["createdAt"]);
      if (previewItem.containsKey("private")) {
        previewData.isPrivate = previewItem["private"];
      }

      previewDatasList.add(previewData);
    }
    return previewDatasList;
  }

  static Future<Object> getVideoPage(String id) async {
    try {
      VideoData videoData = VideoData();
      dynamic video;

      await Dio().get("https://api.iwara.tv/video/$id").then((value) {
        video = value.data;
      });

      if (video["embedUrl"] != null) {
        videoData.youtubeUrl = video["embedUrl"];
      }

      videoData.createDate = DateTime.parse(video["createdAt"]);
      videoData.updateDate = DateTime.parse(video["updatedAt"]);
      videoData.title = video["title"];
      videoData.likes = video["numLikes"];
      videoData.description = video["body"] ?? "";
      videoData.views = video["numViews"];
      videoData.isPrivate = video["private"];

      var uploader = video["user"];

      var avatarUrl = uploader["avatar"] == null
          ? "https://www.iwara.tv/images/default-avatar.jpg"
          : "https://files.iwara.tv/image/avatar/${uploader["avatar"]["id"]}/${uploader["avatar"]["name"]}";

      videoData.uploader = UserData(
          id: uploader["id"],
          userName: uploader["username"],
          nickName: uploader["name"],
          avatarUrl: avatarUrl);

      for (var tag in video["tags"]) {
        videoData.tags.add(TagData(tag["id"], tag["type"]));
      }

      videoData.fetchUrl = video["fileUrl"];
      List<ResolutionData> resolutions = <ResolutionData>[];

      var vid = RegExp(r'file/(\w+-\w+-\w+-\w+-\w+)\?')
          .firstMatch(videoData.fetchUrl)
          ?.group(1);
      var expires =
          RegExp(r'expires=(\d+)').firstMatch(videoData.fetchUrl)?.group(1);

      videoData.xversion =
          sha1.convert(utf8.encode('${vid}_$expires$salt')).toString();

      await getVideoResolutions(videoData.fetchUrl, videoData.xversion)
          .then((value) => resolutions = value);

      if (resolutions.isNotEmpty) {
        videoData.fetchFailed = false;
        videoData.resolutions = resolutions;
      }

      await Dio()
          .get(
              "https://api.iwara.tv/videos?user=${videoData.uploader.id}&exclude=$id&limit=6")
          .then((value) {
        videoData.moreFromUser = analyseMediaPreviewsJson(value.data);
      });

      await Dio().get("https://api.iwara.tv/video/$id/related").then((value) {
        videoData.moreLikeThis = analyseMediaPreviewsJson(value.data);
      });

      await getComments(id: id, type: "video", pageNum: 0, isPreview: true)
          .then((value) => videoData.comments = value);

      return videoData;
    } catch (e, stackTrace) {
      return "$e";
    }
  }

  static Future<Object> getImagePage(String id) async {
    try {
      ImageData imageData = ImageData();
      dynamic image;

      await Dio().get("https://api.iwara.tv/image/$id").then((value) {
        image = value.data;
      });

      imageData.createDate = DateTime.parse(image["createdAt"]);
      imageData.updateDate = DateTime.parse(image["updatedAt"]);
      imageData.title = image["title"];
      imageData.likes = image["numLikes"];
      imageData.description = image["body"] ?? "";
      imageData.views = image["numViews"];

      var uploader = image["user"];

      var avatarUrl = uploader["avatar"] == null
          ? "https://www.iwara.tv/images/default-avatar.jpg"
          : "https://files.iwara.tv/image/avatar/${uploader["avatar"]["id"]}/${uploader["avatar"]["name"]}";

      imageData.uploader = UserData(
          id: uploader["id"],
          userName: uploader["username"],
          nickName: uploader["name"],
          avatarUrl: avatarUrl);

      for (var tag in image["tags"]) {
        imageData.tags.add(TagData(tag["id"], tag["type"]));
      }

      for (var imageFile in image["files"]) {
        imageData.imageUrls.add(
            "https://files.iwara.tv/image/large/${imageFile["id"]}/${imageFile["name"]}");
      }

      await Dio()
          .get(
              "https://api.iwara.tv/images?user=${imageData.uploader.id}&exclude=$id&limit=6")
          .then((value) {
        imageData.moreFromUser = analyseMediaPreviewsJson(value.data);
      });

      await Dio().get("https://api.iwara.tv/image/$id/related").then((value) {
        imageData.moreLikeThis = analyseMediaPreviewsJson(value.data);
      });

      await getComments(id: id, type: "image", pageNum: 0, isPreview: true)
          .then((value) => imageData.comments = value);

      return imageData;
    } catch (e, stackTrace) {
      print("$stackTrace");
      return "$e";
    }
  }

  static Future<List<ResolutionData>> getVideoResolutions(
      String url, String xversion) async {
    List<ResolutionData> resolution = [];

    try {
      await Dio()
          .get(url, options: Options(headers: {'x-version': xversion}))
          .then((value) {
        if (value.data is List) {
          for (var resolutionItem in value.data) {
            resolution.add(ResolutionData(
                name: resolutionItem["name"],
                viewUrl: "https:${resolutionItem["src"]["view"]}",
                downloadUrl: "https:${resolutionItem["src"]["download"]}"));
          }
        }
      });
    } catch (e) {}

    return resolution;
  }

  static Future<List<CommentData>> getComments(
      {required String id,
      required String type,
      required int pageNum,
      bool isPreview = false}) async {
    try {
      List<CommentData> commentsList = [];
      dynamic comments;

      String url = "https://api.iwara.tv/${type}/$id/comments?page=$pageNum";

      await Dio().get(url).then((value) {
        comments = value.data;
      });

      for (var commentItem in comments["results"]) {
        CommentData commentData = analyseCommentJson(commentItem);

        if (commentData.repliesNum > 0 && isPreview) {
          await Dio()
              .get(
                  "https://api.iwara.tv/${type}/$id/comments?parent=${commentData.id}&limit=2")
              .then((value) {
            for (var child in value.data["results"]) {
              commentData.children.add(analyseCommentJson(child));
            }
          });
        }

        commentsList.add(commentData);
      }
      return commentsList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static CommentData analyseCommentJson(dynamic commentItem) {
    var user = commentItem["user"];

    var avatarUrl = user["avatar"] == null
        ? "https://www.iwara.tv/images/default-avatar.jpg"
        : "https://files.iwara.tv/image/avatar/${user["avatar"]["id"]}/${user["avatar"]["name"]}";

    CommentData commentData = CommentData(
        id: commentItem["id"],
        user: UserData(
            id: user["id"],
            userName: user["username"],
            nickName: user["name"],
            avatarUrl: avatarUrl),
        createDate: DateTime.parse(commentItem["createdAt"]),
        content: commentItem["body"]);

    commentData.updateDate = DateTime.parse(commentItem["updatedAt"]);

    commentData.repliesNum = commentItem["numReplies"];

    if (commentItem["parent"] != null) {
      commentData.parentId = commentItem["parent"]["id"];
    }
    return commentData;
  }
}
