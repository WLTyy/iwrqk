import 'package:flutter/material.dart';

class VideoPreview extends StatelessWidget {
  final String imageSrc;
  final String title;
  final String uperName;
  final String plays;
  final String likes;
  final String duration;

  const VideoPreview(
      {required this.imageSrc,
      required this.title,
      required this.uperName,
      required this.plays,
      required this.likes,
      required this.duration,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
            width: 180,
            height: 160,
            child: Column(children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      width: 180,
                      height: 100,
                      color: Colors.black,
                      child: Image.network(
                        imageSrc,
                        fit: BoxFit.contain,
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 77.5),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black45],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    width: 180,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.play_arrow_rounded,
                                size: 12.5,
                                color: Colors.white,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 2, right: 5),
                                  child: Text(
                                    plays,
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  )),
                              const Icon(
                                Icons.thumb_up,
                                size: 12.5,
                                color: Colors.white,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 2),
                                  child: Text(
                                    likes,
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.white),
                                  ))
                            ],
                          ),
                          Text(
                            duration,
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 12.5),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 13,
                                  color: Colors.grey,
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: Text(uperName,
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.grey)))
                              ]))
                    ]),
              ))
            ])));
  }
}
