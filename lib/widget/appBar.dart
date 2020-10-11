import 'package:flutter/material.dart';
import 'package:movie/providerModels/themeModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({
    Key key,
  })  : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeNotifier>(context,listen: false);
    final isDark = themeProvider.getIsDark();

    return AppBar(
      title: Text('Movie DB'),
      actions: [
        Row(
          children: [
            Text(isDark ? 'Dark' : 'Light'),
            Switch(
                value: isDark ? true : false,
                onChanged: (toggle) {
                  if (toggle)
                    themeProvider.setTheme(darkTheme);
                  else
                    themeProvider.setTheme(lightTheme);

                  themeProvider.setIsDark(toggle);
                  saveTheme(toggle);
                  // setState(() {});
                })
          ],
        )
      ],
    );
  }

  Future saveTheme(bool toogle) async {
    var themePerfs = await SharedPreferences.getInstance();
    themePerfs.setBool('darkMode', toogle);
  }
}
