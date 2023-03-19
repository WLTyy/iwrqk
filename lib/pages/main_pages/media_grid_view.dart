import 'dart:math';

import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/network/network_util.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../common/classes.dart';
import '../../network/api.dart';
import '../../widgets/media_preview.dart';

class MediaGridView extends StatefulWidget {
  final SortSetting sortSetting;
  final FilterSetting filterSetting;
  final String? uploaderName;

  const MediaGridView({
    required Key key,
    this.uploaderName,
    required this.sortSetting,
    required this.filterSetting,
  }) : super(key: key);

  @override
  State<MediaGridView> createState() => _MediaGridViewState();
}

class _MediaGridViewState extends State<MediaGridView>
    with AutomaticKeepAliveClientMixin {
  List<MediaPreviewData> _data = [];
  late EasyRefreshController _easyRefreshController;
  final NetworkUtil _networkUtil = NetworkUtil();
  bool _fristLoad = true;
  bool _isLoading = false;
  int _currentPage = 0;
  late FilterSetting _lastFilterSetting;

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
    _lastFilterSetting = widget.filterSetting;
    
    if (!mounted) return;

    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      String path = "";
      Map<String, dynamic> query = {};

      switch (widget.sortSetting.sourceType) {
        case SourceType.thirdparty:
          //url = '?page=$_currentPage';
          break;
        case SourceType.videos:
          path = "/videos";
          break;
        case SourceType.images:
          path = "/images";
          break;
        case SourceType.uploader_videos:
          path = "/videos";
          break;
        case SourceType.uploader_images:
          path = "/videos";
          break;
      }

      query = {
        "sort": widget.sortSetting.orderType,
        "rating": widget.filterSetting.ratingType ?? RatingType.all,
        "page": _currentPage
      };

      if (widget.filterSetting.year != null) {
        if (widget.filterSetting.month != null) {
          query.addAll({
            "date": "${widget.filterSetting.year}-${widget.filterSetting.month}"
          });
        } else {
          query.addAll({"date": "${widget.filterSetting.year}"});
        }
      }

      try {
        List<MediaPreviewData> newData = [];
        await _networkUtil.get(path, queryParameters: query).then((value) {
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

    _lastFilterSetting = widget.filterSetting;

    /*
    if (_fristLoad) {
      _easyRefreshController.callLoad();
      //_loadData();
      _fristLoad = false;
    }*/
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  ClassicHeader _buildRefreshHeader() {
    return ClassicHeader(
        showMessage: false,
        showText: false,
        pullIconBuilder: (context, state, animation) {
          return Transform.rotate(
              angle: -pi * animation,
              child: Icon(
                  state.reverse
                      ? (state.axis == Axis.vertical
                          ? CupertinoIcons.arrow_up
                          : CupertinoIcons.arrow_left)
                      : (state.axis == Axis.vertical
                          ? CupertinoIcons.arrow_down
                          : CupertinoIcons.arrow_right),
                  color: Colors.grey));
        },
        succeededIcon: Icon(CupertinoIcons.check_mark, color: Colors.grey),
        failedIcon: Icon(CupertinoIcons.xmark, color: Colors.grey),
        noMoreIcon: Icon(CupertinoIcons.archivebox, color: Colors.grey));
  }

  ClassicFooter _buildRefreshFooter() {
    return ClassicFooter(
        showMessage: false,
        showText: false,
        pullIconBuilder: (context, state, animation) {
          return Transform.rotate(
              angle: -pi * animation,
              child: Icon(
                state.reverse
                    ? (state.axis == Axis.vertical
                        ? CupertinoIcons.arrow_up
                        : CupertinoIcons.arrow_left)
                    : (state.axis == Axis.vertical
                        ? CupertinoIcons.arrow_down
                        : CupertinoIcons.arrow_right),
                color: Colors.grey,
              ));
        },
        succeededIcon: Icon(CupertinoIcons.check_mark, color: Colors.grey),
        failedIcon: Icon(CupertinoIcons.xmark, color: Colors.grey),
        noMoreIcon: Icon(CupertinoIcons.archivebox, color: Colors.grey));
  }

  @override
  Widget build(BuildContext context) {
    if (!(_lastFilterSetting == widget.filterSetting)) {
      _data = [];
    }
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
