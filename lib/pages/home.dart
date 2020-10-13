import 'package:flutter/material.dart';
import 'package:movie/constants.dart';

import 'package:movie/widget/homePage.dart';

class HomePage extends StatelessWidget {
  final List homePageList = [
    {'title': 'Popular', 'url': popuarlMovie},
    {'title': 'Now Playing', 'url': nowPlaying},
    {'title': 'UpComing', 'url': upComingMovie},
        // {'title': 'Popular', 'url': popuarlMovie},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: homePageList
            .map(
              (e) => Container(
                height: 280,
                child: HomePageWidget(
                  title: e['title'],
                  url: e['url'],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
