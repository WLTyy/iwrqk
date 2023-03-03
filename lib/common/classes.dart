enum MediaType { video, image }

enum SourceType { thirdparty, videos, images, videos_3 }

enum SortMethod { ascend, descend }

//enum OrderType { date, views, likes, viewsToday, random }

class OrderType {
  String? date;
  String? views;
  final String likes = "likes";
  final String viewsToday = "daycount";
  final String random = "random";
  
  OrderType(SourceType type) {
    if (type == SourceType.videos_3) {
      date = "created";
      views = "totalcount";
    } else {
      date = "date";
      views = "views";
    }
  }
}

class MediaPreviewData {
  late MediaType type;
  late String title;
  late String url;
  String? coverImageUrl;
  String? uploaderName;
  String? uploaderHomePageUrl;
  late String views;
  late String likes;
  late bool isGallery;

  MediaPreviewData();
}

class UserData {
  final String name;
  final String avatarUrl;
  final String homepageUrl;

  UserData(this.name, this.avatarUrl, this.homepageUrl);
}

class CommentData {
  final UserData user;
  final String date;
  final String content;
  UserData? replyTo;
  List<CommentData> children = <CommentData>[];

  CommentData(this.user, this.date, this.content);
}

class VideoData {
  late UserData uploader;
  late String date;
  late String title;
  late String description;
  late String views;
  String? likes;
  Map<String, String> resolution = {};
  List<CommentData> comments = <CommentData>[];

  VideoData();
}

class UploaderProfile {
  String avatarUrl;
  String name;
  String describe;
  String joinDate;
  String lastActiveDate;
  late List<String> videosUrls;

  UploaderProfile(this.avatarUrl, this.name, this.describe, this.joinDate,
      this.lastActiveDate);
}
