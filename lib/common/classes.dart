enum MediaType { video, image }

enum SourceType {
  thirdparty,
  videos,
  images,
  uploader_videos,
  uploader_images,
  videos_3
}

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
