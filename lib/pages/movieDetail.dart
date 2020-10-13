import 'package:flutter/material.dart';
import 'package:movie/dataModels/movieDetailModel.dart';
import 'package:movie/providerModels/movie.dart';
import 'package:movie/widget/customScaffold.dart';
import 'package:provider/provider.dart';

@override
class MovieDetail extends StatelessWidget {
  final int id;
  MovieDetail({@required this.id});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureProvider(
      create: (context) => MovieProvider().movieDetail(id),
      child: CustomScaffold(
        widgetData: Container(
          child: Consumer<MovieProviderData>(
            builder: (context, movie, child) => movie == null
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
                              movie.movieModel.posterPath,
                              fit: BoxFit.cover,
                            ),
                            elevation: 5,
                          ),
                          Container(
                            width: size.width,

                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildMovieData(movieDetailUi('Title',
                                      movie.movieModel.originalTitle, size)),
                                  buildMovieData(movieDetailUi(
                                      'Released Date',
                                      movie.movieModel.releaseDate
                                          .toIso8601String(),
                                      size)),
                                  buildMovieData(movieDetailUi(
                                      'Status', movie.movieModel.status, size)),
                                  buildMovieData(movieDetailUi('OverView',
                                      movie.movieModel.overview, size)),
                                  buildMovieData(movieDetailUi(
                                      'Run Time (Mins)',
                                      movie.movieModel.runtime.toString(),
                                      size)),
                                  movie.movieModel.productionCompanies.length !=
                                          0
                                      ? ExpansionTile(
                                          title: Text('Company'),
                                          children: movie
                                              .movieModel.productionCompanies
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
                                                            width: size.width *
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
