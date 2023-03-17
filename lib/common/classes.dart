enum MediaType { video, image }

enum SourceType {
  thirdparty,
  videos,
  images,
  uploader_videos,
  uploader_images,
}

class SortSetting {
  final SourceType sourceType;
  final String orderType;
  final String ratingType;
  SortSetting(
      {required this.sourceType,
      required this.orderType,
      required this.ratingType});
}

// enum OrderType { date, views, likes, viewsToday, random }

/* Latest, Trending, Popularity, Most views, Most likes */

class OrderType {
  static const String date = "date";
  static const String trending = "trending";
  static const String popularity = "popularity";
  static const String views = "views";
  static const String likes = "likes";

  OrderType();
}

class RatingType {
  static const String all = "all";
  static const String general = "general";
  static const String ecchi = "ecchi";

  RatingType();
}

class MediaPreviewData {
  late MediaType type;
  late DateTime date;
  late String title;
  late String id;
  late String? fileId;
  late int? thumbnailLength;
  late String? thumbnailUrl;
  late int? galleryLength;
  late UserData uploader;
  bool isPrivate = false;
  late int? duration;
  late String ratingType;
  late int views;
  late int likes;

  MediaPreviewData();
}

class UserData {
  final String userName;
  final String nickName;
  final String avatarUrl;

  UserData(this.userName, this.nickName, this.avatarUrl);
}

class CommentData {
  final UserData user;
  final String date;
  final String content;
  int depth = 0;
  UserData? replyTo;
  List<CommentData> children = <CommentData>[];

  CommentData(this.user, this.date, this.content);

  List<CommentData> preorderTraversal() {
    List<CommentData> result = [this];
    for (CommentData child in children) {
      result.addAll(child.preorderTraversal());
    }
    return result;
  }
}

class VideoData {
  late UserData uploader;
  late String date;
  late String title;
  late String description;
  late String views;
  String? processingVideo;
  String? likes;
  Map<String, String> resolution = {};
  List<CommentData> comments = <CommentData>[];
  List<MediaPreviewData> moreFromUser = <MediaPreviewData>[];
  List<MediaPreviewData> moreLikeThis = <MediaPreviewData>[];

  VideoData();
}

class UploaderProfileData {
  late String name;
  late String avatarUrl;
  late String joinDate;
  late String lastLoginTime;
  late bool moreUploadedVideos;
  late bool moreUploadedImages;
  String? description;
  List<MediaPreviewData> uploadedImages = <MediaPreviewData>[];
  List<MediaPreviewData> uploadedVideos = <MediaPreviewData>[];
  List<CommentData> comments = <CommentData>[];

  UploaderProfileData();
}
