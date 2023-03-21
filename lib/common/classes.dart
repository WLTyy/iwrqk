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

  SortSetting({
    required this.sourceType,
    required this.orderType,
  });
}

class FilterSetting {
  String? ratingType;
  int? year;
  int? month;

  @override
  bool operator ==(other) {
    bool flag = false;
    if (other is FilterSetting) {
      if (other.ratingType == null &&
          other.year == null &&
          other.month == null) {
        return true;
      }
      flag = other.ratingType == ratingType &&
          other.year == year &&
          other.month == month;
    }
    return flag;
  }

  FilterSetting({this.ratingType, this.year, this.month});
}

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
  late DateTime createDate;
  late String title;
  late String id;
  String? fileId;
  int? thumbnailLength;
  String? thumbnailUrl;
  int? galleryLength;
  late UserData uploader;
  bool isPrivate = false;
  String? embedUrl;
  int? duration;
  late String ratingType;
  late int views;
  late int likes;

  bool hasCover() {
    bool flag = false;
    if (thumbnailLength != null) {
      if (thumbnailLength != 0) {
        flag = true;
      }
    }
    if (thumbnailUrl != null) {
      flag = true;
    }
    return flag;
  }

  String getCoverUrl() {
    if (fileId != null) {
      return "https://files.iwara.tv/image/thumbnail/$fileId/thumbnail-00.jpg";
    } else {
      return "https://files.iwara.tv$thumbnailUrl";
    }
  }

  MediaPreviewData();
}

class UserData {
  final String id;
  final String userName;
  final String nickName;
  final String avatarUrl;

  UserData(
      {required this.id,
      required this.userName,
      required this.nickName,
      required this.avatarUrl});
}

class CommentData {
  final String id;
  final UserData user;
  final DateTime createDate;
  DateTime? updateDate;
  final String content;
  UserData? replyTo;
  String? parentId;
  int repliesNum = 0;
  List<CommentData> children = <CommentData>[];

  CommentData(
      {required this.id,
      required this.user,
      required this.createDate,
      required this.content});
}

class TagData {
  final String id;
  final String type;

  TagData(this.id, this.type);
}

class MediaData {
  late String id;
  late UserData uploader;
  late DateTime createDate;
  DateTime? updateDate;
  late String title;
  late String description;
  bool isPrivate = false;
  late String fetchUrl;
  late String xversion;
  late int views;
  late int likes;
  List<TagData> tags = <TagData>[];
  List<CommentData> comments = <CommentData>[];
  List<MediaPreviewData> moreFromUser = <MediaPreviewData>[];
  List<MediaPreviewData> moreLikeThis = <MediaPreviewData>[];

  MediaData();
}

class VideoData extends MediaData {
  late String? embedUrl;
  bool fetchFailed = true;
  List<ResolutionData> resolutions = <ResolutionData>[];

  VideoData();
}

class ResolutionData {
  final String name;
  final String viewUrl;
  final String downloadUrl;

  ResolutionData({
    required this.name,
    required this.viewUrl,
    required this.downloadUrl,
  });
}

class ImageData extends MediaData {
  List<String> imageUrls = <String>[];

  ImageData();
}

class UploaderProfileData {
  late UserData uploader;
  late bool isFollowedBy;
  late bool isFollowing;
  late bool isFriend;
  late String bannerUrl;
  late DateTime joinDate;
  DateTime? lastActiveTime;
  late String description;
  late int followers;
  late int following;

  UploaderProfileData();
}
