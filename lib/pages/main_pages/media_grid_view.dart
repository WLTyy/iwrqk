import 'dart:math';

import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../common/classes.dart';
import '../../network/api.dart';
import '../../widgets/media_preview.dart';

class MediaGridView extends StatefulWidget {
  final SortSetting sortSetting;
  final String? uploaderName;

  const MediaGridView({
    required Key key,
    this.uploaderName,
    required this.sortSetting,
  }) : super(key: key);

  @override
  State<MediaGridView> createState() => _MediaGridViewState();
}

class _MediaGridViewState extends State<MediaGridView>
    with AutomaticKeepAliveClientMixin {
  List<MediaPreviewData> _data = [];
  late EasyRefreshController _easyRefreshController;
  ScrollController _scrollController = ScrollController();
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

      switch (widget.sortSetting.sourceType) {
        case SourceType.thirdparty:
          url = '?page=$_currentPage';
          break;
        case SourceType.videos:
          url =
              "https://api.iwara.tv/videos?sort=${widget.sortSetting.orderType}&rating=${widget.sortSetting.ratingType}&page=$_currentPage";
          break;
        case SourceType.images:
          url =
              "https://api.iwara.tv/images?sort=${widget.sortSetting.orderType}&rating=${widget.sortSetting.ratingType}&page=$_currentPage";
          break;
        case SourceType.uploader_videos:
          url =
              'https://www.iwara.tv/users/${widget.uploaderName}/videos?language=en&page=$_currentPage';
          break;
        case SourceType.uploader_images:
          url =
              'https://www.iwara.tv/users/${widget.uploaderName}/images?language=en&page=$_currentPage';
          break;
      }
      try {
        List<MediaPreviewData> newData = [];
        await Dio().get(url).then((value) {
          newData = Api.analyseMediaPreviewsJson(value.data);
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
      } catch (e, stackTrace) {
        _isLoading = false;
        print(stackTrace);

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

  ClassicHeader _buildRefreshHeader() {
    return ClassicHeader(
        showMessage: false,
        showText: false,
        pullIconBuilder: (context, state, animation) {
          return Transform.rotate(
              angle: -pi * animation,
              child: Icon(state.reverse
                  ? (state.axis == Axis.vertical
                      ? CupertinoIcons.arrow_up
                      : CupertinoIcons.arrow_left)
                  : (state.axis == Axis.vertical
                      ? CupertinoIcons.arrow_down
                      : CupertinoIcons.arrow_right)));
        },
        succeededIcon: Icon(CupertinoIcons.check_mark),
        failedIcon: Icon(CupertinoIcons.xmark),
        noMoreIcon: Icon(CupertinoIcons.archivebox));
  }

  ClassicFooter _buildRefreshFooter() {
    return ClassicFooter(
        showMessage: false,
        showText: false,
        pullIconBuilder: (context, state, animation) {
          return Transform.rotate(
              angle: -pi * animation,
              child: Icon(state.reverse
                  ? (state.axis == Axis.vertical
                      ? CupertinoIcons.arrow_up
                      : CupertinoIcons.arrow_left)
                  : (state.axis == Axis.vertical
                      ? CupertinoIcons.arrow_down
                      : CupertinoIcons.arrow_right)));
        },
        succeededIcon: Icon(CupertinoIcons.check_mark),
        failedIcon: Icon(CupertinoIcons.xmark),
        noMoreIcon: Icon(CupertinoIcons.archivebox));
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: _buildRefreshHeader(),
      footer: _buildRefreshFooter(),
      controller: _easyRefreshController,
      refreshOnStart: true,
      refreshOnStartHeader: _buildRefreshHeader(),
      onRefresh: _refresh,
      onLoad: _loadData,
      child: WaterfallFlow.builder(
        padding: EdgeInsets.all(8),
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
