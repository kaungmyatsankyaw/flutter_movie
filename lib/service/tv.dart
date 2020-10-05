import 'package:movie/dataModels/moviesList.dart';
import 'package:movie/dataModels/tvList.dart';
import 'package:movie/service/api.dart';

class TvApi {
  var _apiService = ApiService();

  Future<List<TvList>> getTv(String url,int page) async {
    var result = await _apiService.getDataWithPagination(url,page);
    var tv = result['results'].map<TvList>((e) => TvList.fromJson(e)).toList();
    return tv;
  
  }
}
