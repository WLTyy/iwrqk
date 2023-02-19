import 'dart:ffi';

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
