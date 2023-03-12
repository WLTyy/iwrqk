import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
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
      {required Key key,
      required this.sourceType,
      this.sortMethod,
      required this.orderType})
      : super(key: key);

  @override
  State<MediaGridView> createState() => _MediaGridViewState();
}

class _MediaGridViewState extends State<MediaGridView>
    with AutomaticKeepAliveClientMixin {
  List<MediaPreviewData> _data = [];
  late EasyRefreshController _easyRefreshController;
  bool _fristLoad = true;
  bool _isLoading = false;
  int _currentPage = 0;

  Future<void> _refresh() async {
    if (!mounted) return;
    setState(() {
      _currentPage = 0;
      _data = [];
    });
    await _loadData();
    _easyRefreshController.finishRefresh();
    _easyRefreshController.resetFooter();
  }

  Future<void> _loadData() async {
    if (!mounted) return;

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
        List<MediaPreviewData> newData = [];
        await Dio().get(url).then((value) {
          newData = Spider.analyseMediaPreviewsHtml(value.data);
        });
        setState(() {
          if (newData.isNotEmpty) {
            _data.addAll(newData);
            _currentPage++;
            _isLoading = false;

            _easyRefreshController.finishLoad(IndicatorResult.success);
          } else {
            _isLoading = false;

            //_easyRefreshController.finishLoad(IndicatorResult.noMore);
          }
        });
      } catch (e) {
        _isLoading = false;

        _easyRefreshController.finishLoad(IndicatorResult.fail);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _easyRefreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    /*
    if (_fristLoad) {
      _easyRefreshController.callLoad();
      //_loadData();
      _fristLoad = false;
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: CupertinoHeader(),
      footer: CupertinoFooter(),
      controller: _easyRefreshController,
      refreshOnStart: true,
      refreshOnStartHeader: CupertinoHeader(),
      onRefresh: _refresh,
      onLoad: _loadData,
      child: WaterfallFlow.builder(
        padding: EdgeInsets.all(8),
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
