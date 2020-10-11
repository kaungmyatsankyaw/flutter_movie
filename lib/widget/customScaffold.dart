import 'package:flutter/material.dart';
import 'package:movie/widget/appBar.dart';

class CustomScaffold extends StatelessWidget {
  final Widget widgetData;

  const CustomScaffold({Key key, this.widgetData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 18), child: widgetData),
          Positioned(
            top: 0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: MediaQuery.of(context).size.width,
              height: 30,
              decoration: BoxDecoration(
                  color: Theme.of(context).copyWith().bottomAppBarColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).copyWith().accentColor.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      // offset: Offset(0, 0), // changes position of shadow
                    ),
                  ]),
              child: Text('Detail'),
            ),
          )
        ],
      ),
    );
  }
}
