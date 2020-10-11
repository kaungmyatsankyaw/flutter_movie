import 'package:flutter/material.dart';
import 'package:movie/widget/appBar.dart';

class CustomScaffold extends StatelessWidget {
  final Widget widgetData;

  const CustomScaffold({Key key, this.widgetData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: widgetData,
    );
  }
}
