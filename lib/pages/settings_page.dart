import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../common/global.dart';
import '../common/theme.dart';
import '../l10n.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _themeCurrentIndex = ThemeMode.values[Global.getData('ThemeMode')].index;

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
            L10n.of(context).settings,
          )),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        sections: [
          SettingsSection(
            title: Text(L10n.of(context).appearance),
            tiles: [
              SettingsTile(
                  title: Text(L10n.of(context).theme),
                  trailing: CupertinoSlidingSegmentedControl(
                    children: <int, Widget>{
                      0: Text(L10n.of(context).system),
                      1: Text(L10n.of(context).light_mode),
                      2: Text(L10n.of(context).dark_mode),
                    },
                    groupValue: _themeCurrentIndex,
                    onValueChanged: (value) {
                      setState(() {
                        _themeCurrentIndex = value!;
                        Provider.of<ThemeModeProvider>(context, listen: false)
                            .changeThemeMode(ThemeMode.values[value]);
                      });
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
