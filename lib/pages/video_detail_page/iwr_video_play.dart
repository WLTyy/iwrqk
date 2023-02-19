import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../component/iwr_track_shape.dart';

class IwrVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final VoidCallback fullScreenCallback;

  const IwrVideoPlayer(
      {super.key, required this.videoUrl, required this.fullScreenCallback});

  @override
  _IwrVideoPlayerState createState() => _IwrVideoPlayerState();
}

class _IwrVideoPlayerState extends State<IwrVideoPlayer> {
  late final VideoPlayerController _controller;
  bool _firstPlay = true;
  bool _showControls = true;
  bool _showVolumeSlider = false;
  bool _disableControls = false;
  double _volume = 0.5;
  bool _isFullScreen = false;
  double _progress = 0;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _controller.initialize().then((_) {
      setState(() {});
    });
    _controller.addListener(() {
      setState(() {
        if (_controller.value.isPlaying) {
          double _temp = _controller.value.position.inMilliseconds /
              _controller.value.duration.inMilliseconds;
          _progress = _temp > 1 ? 1 : _temp;
        }
      });
    });
  }

  void _startHideTimer() {
    _hideTimer = Timer(Duration(seconds: 5), () {
      setState(() {
        _showVolumeSlider = false;
        _showControls = false;
      });
    });
  }

  void _stopHideTimer() {
    _hideTimer?.cancel();
  }

  void _onTapPlayButton() {
    if (_firstPlay) {
      _startHideTimer();
      _firstPlay = false;
    }
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  void _onTapVolumeButton() {
    setState(() {
      _showVolumeSlider = !_showVolumeSlider;
    });
  }

  void _onTapPlayer() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideTimer();
    } else {
      _showVolumeSlider = false;
      _stopHideTimer();
    }
    _disableControls = !_showControls;
  }

  void _onVolumeChanged(double value) {
    setState(() {
      _volume = value;
      _controller.setVolume(value);
    });
  }

  void _onTapFullScreenButton() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        widget.fullScreenCallback();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);
      } else {
        widget.fullScreenCallback();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      }
    });
  }

  void _onDragUpdate(double value) {
    setState(() {
      _progress = value;
      if (_progress < 0) {
        _progress = 0;
      } else if (_progress > 1) {
        _progress = 1;
      }
      _controller.seekTo(Duration(
          milliseconds:
              (_progress * _controller.value.duration.inMilliseconds).toInt()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideTimer?.cancel();
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    super.dispose();
  }

  String _formatTime(Duration time) {
    List<String> parts = time.toString().split(".");
    return parts[0];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: _isFullScreen
            ? MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewPadding.top
            : null,
        child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: GestureDetector(
                onTap: _onTapPlayer,
                child: Stack(fit: StackFit.expand, children: [
                  VideoPlayer(_controller),
                  AnimatedOpacity(
                      opacity: _showControls ? 1 : 0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                      onEnd: () {
                        setState(() {
                          _disableControls = !_showControls;
                        });
                      },
                      child: Visibility(
                          visible: !_disableControls,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Colors.black45,
                                        Colors.black26,
                                        Colors.black12,
                                        Colors.transparent
                                      ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)),
                                  child: Visibility(
                                      visible: !_isFullScreen,
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(CupertinoIcons.back,
                                              size: 30, color: Colors.white))),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 15),
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Colors.transparent,
                                        Colors.black12,
                                        Colors.black26,
                                        Colors.black45
                                      ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: GestureDetector(
                                            onTap: _onTapPlayButton,
                                            child: Icon(
                                                _controller.value.isPlaying
                                                    ? CupertinoIcons.pause
                                                    : CupertinoIcons
                                                        .play_arrow_solid,
                                                color: Colors.white)),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(children: [
                                            AnimatedOpacity(
                                                opacity:
                                                    _showVolumeSlider ? 1 : 0,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.linear,
                                                child: Visibility(
                                                    child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      color: Colors.black
                                                          .withOpacity(0.5)),
                                                  child: RotatedBox(
                                                      quarterTurns: 3,
                                                      child: SliderTheme(
                                                          data: SliderThemeData(
                                                            trackHeight: 5,
                                                            trackShape:
                                                                IwrTrackShape(),
                                                            thumbShape:
                                                                RoundSliderThumbShape(
                                                                    enabledThumbRadius:
                                                                        5),
                                                            thumbColor:
                                                                Colors.white,
                                                            activeTrackColor:
                                                                Colors.white,
                                                            inactiveTrackColor:
                                                                Colors.white
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                          child: SizedBox(
                                                            height: 15,
                                                            width: 75,
                                                            child: Slider(
                                                              onChanged:
                                                                  _onVolumeChanged,
                                                              value: _volume,
                                                            ),
                                                          ))),
                                                ))),
                                            GestureDetector(
                                                onTap: _onTapVolumeButton,
                                                child: Icon(
                                                  _controller.value.volume > 0
                                                      ? CupertinoIcons.volume_up
                                                      : CupertinoIcons
                                                          .volume_mute,
                                                  color: Colors.white,
                                                ))
                                          ])),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "${_formatTime(_controller.value.position)} / ${_formatTime(_controller.value.duration)}",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SliderTheme(
                                            data: SliderThemeData(
                                              trackHeight: 5,
                                              trackShape: IwrTrackShape(),
                                              thumbShape: RoundSliderThumbShape(
                                                  enabledThumbRadius: 5),
                                              thumbColor: Colors.white,
                                              activeTrackColor: Colors.white,
                                              inactiveTrackColor:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                            child: SizedBox(
                                                height: 15,
                                                child: Slider(
                                                  value: _progress,
                                                  onChanged: _onDragUpdate,
                                                )),
                                          ),
                                        ],
                                      )),
                                      GestureDetector(
                                        onTap: _onTapFullScreenButton,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Icon(
                                              _isFullScreen
                                                  ? CupertinoIcons
                                                      .fullscreen_exit
                                                  : CupertinoIcons.fullscreen,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ])))
                ]))));
  }
}
