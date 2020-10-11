import 'package:movie/dataModels/movieDetailModel.dart';
import 'package:movie/dataModels/moviesList.dart';
import 'package:movie/service/api.dart';

class MovieApi {
  var _apiService = ApiService();

  Future<List<MovieList>> getMovie(String url) async {
    var result = await _apiService.getMethod(url);
    var movies =
        result['results'].map<MovieList>((e) => MovieList.fromJson(e)).toList();
    return movies;
    // print(result['results'].toString());
  }

  Future<MovieDetailModel> getDetail(String url) async {
    var result = await _apiService.getMethod(url);
    return  MovieDetailModel.fromJson(result);
  }
}
