import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class IwrGallery extends StatefulWidget {
  final List<String> imageUrls;
  final bool isfullScreen;

  const IwrGallery({
    Key? key,
    required this.imageUrls,
    this.isfullScreen = false,
  }) : super(key: key);

  @override
  State<IwrGallery> createState() => _IwrGalleryState();
}

class _IwrGalleryState extends State<IwrGallery> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _currentIndex = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildLoading(ImageChunkEvent? event) {
    double value = event == null || event.expectedTotalBytes == null
        ? 0
        : event.cumulativeBytesLoaded / event.expectedTotalBytes!;
    return Center(
      child: CircularProgressIndicator(
        value: value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: SafeArea(
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                customSize: widget.isfullScreen
                    ? null
                    : Size.copy(MediaQuery.of(context).size),
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  var imageProvider =
                      CachedNetworkImageProvider(widget.imageUrls[index]);

                  return PhotoViewGalleryPageOptions(
                    imageProvider: imageProvider,
                    initialScale: PhotoViewComputedScale.contained,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: widget.imageUrls[index]),
                    filterQuality: FilterQuality.high,
                    errorBuilder: (context, error, stackTrace) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              imageProvider.evict();
                            });
                          },
                          child: Center(
                            child: Icon(
                              CupertinoIcons.arrow_clockwise,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                          ));
                    },
                  );
                },
                itemCount: widget.imageUrls.length,
                loadingBuilder: (context, event) => Center(
                  child: _buildLoading(event),
                ),
                pageController: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              IconButton(
                  onPressed: () {
                    if (widget.isfullScreen) {
                      Navigator.pop(context);
                    } else {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Scaffold(
                          body: IwrGallery(
                            isfullScreen: true,
                            imageUrls: widget.imageUrls,
                          ),
                        ),
                      ));
                    }
                  },
                  icon: Icon(
                    widget.isfullScreen
                        ? CupertinoIcons.back
                        : CupertinoIcons.fullscreen,
                    size: 30,
                    color: Colors.white,
                  )),
              if (widget.imageUrls.length <= 15)
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.imageUrls.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(index,
                              duration: Duration(milliseconds: 150),
                              curve: Curves.bounceIn);
                        },
                        child: Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
            ],
          ),
        ));
  }
}
