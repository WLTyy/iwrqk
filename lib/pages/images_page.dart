import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/iwr_appbar.dart';
import '../common/global.dart';
import '../common/theme.dart';
import '../l10n.dart';

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

  Future<Null> _onRefresh() {
    return Future.delayed(Duration(seconds: 5), () {
      // 延迟5s完成刷新
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return IwrAppBar(
      showFilter: true,
      tabList: {
        L10n.of(context).latest: Container(),
        L10n.of(context).toplist: Container(),
        L10n.of(context).popular: Container(),
      },
      tabController: _tabController,
    );
  }
}
