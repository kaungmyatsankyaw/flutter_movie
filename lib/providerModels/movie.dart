import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/dataModels/movieDetailModel.dart';
import 'package:movie/service/movie.dart';

class MovieProvider {
  Future<MovieProvider> create() async {
    return MovieProvider();
  }

  Future<MovieProviderData> movieDetail(int id) async {
    var movieData = await MovieApi().getDetail("movie/" + id.toString());
    return MovieProviderData(movieModel: movieData);
  }
}

class MovieProviderData {
  MovieDetailModel movieModel;

  MovieProviderData({this.movieModel});
}
