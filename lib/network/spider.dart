import 'package:dio/dio.dart';
import 'package:html/parser.dart';

import '../common/classes.dart';

class Spider {
  static Future<List<MediaPreviewData>?> getMediaPreviews(String url) async {
    try {
      List<MediaPreviewData>? result;
      await Dio().get(url).then((value) {
        result = analyseMediaPreviewsHtml(value.data);
      });
      return result;
    } catch (e) {
      throw e;
    }
    return null;
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

      var titleDom = previewItem.querySelector('h3.title > a')!;
      previewData.url = titleDom.attributes['href']!;
      previewData.title = titleDom.text;

      var coverImageDom = previewItem.querySelector('img');
      previewData.coverImageUrl = coverImageDom == null
          ? null
          : "https:${coverImageDom.attributes['src']!}";

      var uploaderDom = previewItem.querySelector('a.username')!;
      previewData.uploaderName = uploaderDom.text;
      previewData.uploaderHomePageUrl = uploaderDom.attributes['href']!;

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
}
