import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwrqk/widgets/iwr_appbar.dart';
import 'package:iwrqk/widgets/iwr_gallery.dart';
import 'package:iwrqk/widgets/reloadable_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.back, size: 30)),
            centerTitle: true,
            title: Text(
              "Search",
            )),
        body: AspectRatio(
          aspectRatio: 4 / 3,
          child: IwrGallery(
            imageUrls: [
              "https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExMTNlMDA2NjJjNWRmMDdlOTYwYzUzZTliNTk3NGJmNGRkZDhlZmMwYiZjdD1n/l2JhIUyUs8KDCCf3W/giphy.gif",
              "https://media3.giphy.com/media/v1.Y2lkPTc5MGI3NjExMTNlMDA2NjJjNWRmMDdlOTYwYzUzZTliNTk3NGJmNGRkZDhlZmMwYiZjdD1n/l2JhIUyUs8KDCCf3W/giphy.gif"
            ],
          ),
        ));
  }
}
