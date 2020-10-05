import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/dataModels/moviesList.dart';
import 'package:movie/pages/movieDetail.dart';
import 'package:movie/service/movie.dart';

// ignore: must_be_immutable
class HomePageWidget extends StatelessWidget {
  String title;
  String url;
  HomePageWidget({@required this.title, @required this.url});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(this.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
            FlatButton.icon(
                onPressed: null,
                icon: Icon(Icons.all_inclusive),
                label: Text(
                  'See All',
                ))
          ]),
          Expanded(
            child: FutureBuilder<List<MovieList>>(
                future: MovieApi().getMovie(this.url),
                builder: (context, snapshot) => snapshot.connectionState !=
                        ConnectionState.done
                    ? Center(
                        child: CircularProgressIndicator(
                          semanticsLabel: 'Loading',
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int index) => Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => MovieDetail(id:snapshot.data[index].id))),
                            child: Card(
                              semanticContainer: true,
                              child:
                                  posterImage(snapshot.data[index].posterPath),
                              elevation: 5,
                            ),
                          ),
                        ),
                      )),
          )
        ],
      ),
    );
  }

  Widget posterImage(String image) {
    // return CachedNetworkImage(
    //   fit: BoxFit.cover,
    //   imageUrl: image,
    //   progressIndicatorBuilder: (context, url, downloadProgress) =>
    //       CircularProgressIndicator(value: downloadProgress.progress),
    //   errorWidget: (context, url, error) => Icon(Icons.error),
    // );
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Image.network(
        "http://via.placeholder.com/200x150",
        fit: BoxFit.fill,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
