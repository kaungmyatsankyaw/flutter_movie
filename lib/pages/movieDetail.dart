import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/constants.dart';
import 'package:movie/dataModels/movieDetailModel.dart';
import 'package:movie/service/movie.dart';
import 'package:movie/widget/customScaffold.dart';

class MovieDetail extends StatefulWidget {
  final int id;
  MovieDetail({@required this.id});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  Future<MovieDetailModel> getData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData = MovieApi().getDetail(movieDetail + widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomScaffold(
      widgetData: Container(
        child: FutureBuilder(
          future: getData,
          builder: (context, AsyncSnapshot<MovieDetailModel> snapshot) =>
              snapshot.connectionState != ConnectionState.done
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.network(
                                snapshot.data.posterPath,
                                fit: BoxFit.cover,
                              ),
                              elevation: 5,
                            ),
                            Container(
                              width: size.width,

                              // height: size.height,
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    buildMovieData(movieDetailUi('Title',
                                        snapshot.data.originalTitle, size)),
                                    buildMovieData(movieDetailUi(
                                        'Released Date',
                                        snapshot.data.releaseDate
                                            .toIso8601String(),
                                        size)),
                                    buildMovieData(movieDetailUi(
                                        'Status', snapshot.data.status, size)),
                                    buildMovieData(movieDetailUi('OverView',
                                        snapshot.data.overview, size)),
                                    buildMovieData(movieDetailUi(
                                        'Run Time (Mins)',
                                        snapshot.data.runtime.toString(),
                                        size)),
                                    snapshot.data.productionCompanies.length !=
                                            0
                                        ? ExpansionTile(
                                            title: Text('Company'),
                                            children: snapshot
                                                .data.productionCompanies
                                                .map<Widget>((e) {
                                              return Container(
                                                margin: EdgeInsets.all(10),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Container(
                                                              width:
                                                                  size.width *
                                                                      0.5,
                                                              child: Text(
                                                                e.name,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                              )),
                                                          Expanded(
                                                            child: Container(
                                                              child: e.logoPath !=
                                                                      null
                                                                  ? Image.network(
                                                                      'https://image.tmdb.org/t/p/original/' +
                                                                          e.logoPath
                                                                              .toString())
                                                                  : Image.network(
                                                                      'https://via.placeholder.com/200.png/09f/fff'),
                                                            ),
                                                          )
                                                        ]),
                                                    Divider(
                                                        color: ThemeData()
                                                            .accentColor),
                                                    SizedBox(
                                                      height: 10,
                                                    )
                                                  ],
                                                ),
                                              );
                                            }).toList())
                                        : Container()
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  Widget buildMovieData(Widget wid) {
    return Container(
      padding: EdgeInsets.all(10),
      child: wid,
    );
  }

  Widget movieDetailUi(String title, String text, Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          width: size.width * 0.35,
        ),
        Container(
            width: size.width * 0.5,
            child: Text(
              text,
              textAlign: TextAlign.justify,
              textDirection: TextDirection.ltr,
            ))
      ],
    );
  }
}
