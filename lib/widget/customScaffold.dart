import 'package:flutter/material.dart';
import 'package:movie/providerModels/movie.dart';
import 'package:movie/widget/appBar.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatelessWidget {
  final Widget widgetData;

  const CustomScaffold({Key key, this.widgetData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var breadCrumb = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: widgetData
    );
  }
}

