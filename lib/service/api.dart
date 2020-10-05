import 'package:dio/dio.dart';
import 'package:movie/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  Dio _dio = Dio();

  ApiService() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    // _dio.interceptors.add(PrettyDioLogger());
  }

  Future<dynamic> getMethod(String url) async {
    Response response = await _dio.get(url + '?api_key=$apiKey');
    return response.data;
  }

  Future<dynamic> getDataWithPagination(String url, int page) async {
    Response response =
        await _dio.get(url + '?api_key=$apiKey' + '&page=$page');
    return response.data;
  }
}
