import 'package:flutter/material.dart';

import '../l10n.dart';
import '../widgets/appbarx.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: NestedScrollView(
        body: Center(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            AppBarX(
              innerBoxIsScrolled: innerBoxIsScrolled,
              showFilter: true,
              tabList: [
                L10n.of(context).latest,
                L10n.of(context).toplist,
                L10n.of(context).popular
              ],
              tabController: _tabController,
            )
          ];
        },
      ),
    );
  }
}
