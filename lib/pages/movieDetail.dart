// import 'package:flutter/material.dart';
// import 'package:movie/constants.dart';
// import 'package:movie/dataModels/movieDetailModel.dart';
// import 'package:movie/service/movie.dart';
// import 'package:movie/widget/customScaffold.dart';

// class MovieDetail extends StatefulWidget {
//   final int id;
//   MovieDetail({@required this.id});

//   @override
//   _MovieDetailState createState() => _MovieDetailState();
// }

// class _MovieDetailState extends State<MovieDetail> {
//   Future<MovieDetailModel> getData;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData = MovieApi().getDetail(movieDetail + widget.id.toString());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       widgetData: Container(
//         child:
// FutureBuilder(
//           future: getData,
//           builder: (context, AsyncSnapshot<MovieDetailModel> snapshot) =>
//               snapshot.connectionState != ConnectionState.done
//                   ? Center(
//                       child: CircularProgressIndicator(),
//                     )
//                   : Card(
//                       semanticContainer: true,
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       child: Image.network(
//                         snapshot.data.posterPath,
//                         fit: BoxFit.cover,
//                       ),

//                       elevation: 5,

//                     ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:movie/dataModels/movieDetailModel.dart';
import 'package:movie/service/movie.dart';
import 'package:movie/widget/customScaffold.dart';

import '../constants.dart';

class MovieDetail extends StatelessWidget {
  final int id;

   MovieDetail({@required this.id});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widgetData: FutureBuilder<MovieDetailModel>(
        future: MovieApi().getDetail(movieDetail + id.toString()),
        builder: (context, snapshot) => Text(snapshot.connectionState.toString())
            // snapshot.connectionState != ConnectionState.done
            //     ? Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     : Card(
            //         semanticContainer: true,
            //         clipBehavior: Clip.antiAliasWithSaveLayer,
            //         child: Image.network(
            //           snapshot.data.posterPath,
            //           fit: BoxFit.cover,
            //         ),
            //         elevation: 5,
            //       ),
      ),
    );
  }
}
