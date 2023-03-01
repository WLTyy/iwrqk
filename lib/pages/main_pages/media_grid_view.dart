import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../common/classes.dart';
import '../../network/spider.dart';
import '../../widgets/media_preview.dart';

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
  EasyRefreshController _easyRefreshController = EasyRefreshController();
  bool _isLoading = false;
  int _currentPage = 0;

  Future<void> _refresh() async {
    setState(() {
      _currentPage = 0;
      _data = [];
    });
    await _loadData();
  }

  Future<void> _loadData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      var url = "";

      switch (widget.sourceType) {
        case SourceType.thirdparty:
          url = '?page=$_currentPage';
          break;
        case SourceType.videos:
          url =
              'https://www.iwara.tv/videos?language=en&sort=${widget.orderType}&page=$_currentPage';
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
          _isLoading = false;
        });
      } catch (e) {
        _isLoading = false;
        print(e);
      }
    }
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: CupertinoHeader(),
      footer: CupertinoFooter(),
      controller: _easyRefreshController,
      onRefresh: _refresh,
      onLoad: _loadData,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: WaterfallFlow.builder(
            shrinkWrap: true,
            gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _data.length,
            itemBuilder: (BuildContext context, int index) {
              return AspectRatio(
                aspectRatio: 16 / 15,
                child: MediaPreview(data: _data[index]),
              );
            },
          )),
    );
  }
}
