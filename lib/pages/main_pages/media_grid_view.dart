import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../common/classes.dart';
import '../../network/spider.dart';
import '../../widgets/video_preview.dart';

class MediaGridView extends StatefulWidget {
  final SourceType sourceType;
  final SortMethod? sortMethod;
  final String orderType;

  const MediaGridView(
      {Key? key,
      required this.sourceType,
      this.sortMethod,
      required this.orderType})
      : super(key: key);

  @override
  State<MediaGridView> createState() => _MediaGridViewState();
}

class _MediaGridViewState extends State<MediaGridView> {
  List<MediaPreviewData> _data = [];
  ScrollController _scrollController = ScrollController();
  int _currentPage = 0;

  Future<void> _loadData() async {
    var url = "";
    switch (widget.sourceType) {
      case SourceType.thirdparty:
        url = '?page=$_currentPage';
        break;
      case SourceType.videos:
        url =
            'https://ecchi.iwara.tv/videos?language=en&sort=${widget.orderType}&page=$_currentPage';
        break;
      case SourceType.images:
        url =
            'https://ecchi.iwara.tv/images?language=en&sort=${widget.orderType}&page=$_currentPage';
        break;
      case SourceType.videos_3:
        url =
            'https://www.iwara.tv/videos-3?language=en&sort_by=${widget.orderType}&sort_order=${widget.sortMethod! == SortMethod.ascend ? "ASC" : "DESC"}&page=$_currentPage';
        break;
    }
    try {
      var newData;
      await Dio().get(url).then((value) {
        newData = Spider.analyseMediaPreviewsHtml(value.data);
        print("ok");
      });
      setState(() {
        _data.addAll(newData);
        _currentPage++;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 16 / 15,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          return MediaPreview(
            data: _data[index],
          );
        });
  }
}
