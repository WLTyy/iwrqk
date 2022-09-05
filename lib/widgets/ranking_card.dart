import 'package:flutter/material.dart';

class RankingCard extends StatelessWidget {
  final String title;
  final Map<String, String> itemMap;

  const RankingCard({required this.title, required this.itemMap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RankingItem extends StatelessWidget {
  final String name;
  final String imageScr;
  final int rank;

  const RankingItem(
      {required this.name,
      required this.imageScr,
      required this.rank,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [Colors.grey, Colors.grey.shade600];
    if (rank == 1) {
      colors = [Colors.yellowAccent, Colors.yellow.shade800];
    } else if (rank == 2) {
      colors = [Colors.lightBlue.shade50, Colors.lightBlue.shade300];
    } else if (rank == 3) {
      colors = [Colors.orange.shade100, Colors.deepOrange.shade300];
    }

    return Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 5,
              color: Colors.grey,
            )
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  width: 100,
                  height: 85,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 2.5),
                            child: ClipOval(
                                child: Image.network(imageScr,
                                    width: 45, height: 45, fit: BoxFit.cover))),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(name,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black)),
                        ),
                      ]),
                ),
                ClipPath(
                    clipper: BackgroundClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: colors,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10))),
                      width: 45,
                      height: 30,
                      child: Container(
                          margin: EdgeInsets.only(left: 7.5, top: 5),
                          child: Text(rank.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1.5, 1.5),
                                    blurRadius: 5,
                                    color: Colors.grey,
                                  )
                                ],
                              ))),
                    ))
              ],
            )));
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width - 27.5, size.height);
    path.quadraticBezierTo(
        size.width - 20, size.height, size.width - 20, size.height - 5);
    path.quadraticBezierTo(size.width - 12.5, 0, size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
