import 'dart:convert';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://zuluresh.onrender.com/';
  String? token;
  Map<String, String>? mainHeaders;

  ApiClient({this.token}) {
    updateHeader(token);
  }

  void updateHeader(String? token) {
    if (token != null) {
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      };
      mainHeaders = header;
    } else {
      mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    }
  }

  Future<Response> postData(String path, Map<String, dynamic>? body,
      Map<String, dynamic>? headers) async {
    try {
      Response response = await _dio
          .post(
            _baseUrl + path,
            data: body,
            options: Options(headers: headers ?? mainHeaders),
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } catch (e) {
      print(e.toString());
      return Response(
        statusCode: 1,
        requestOptions: RequestOptions(
          headers: headers,
          baseUrl: _baseUrl + path,
        ),
      );
    }
  }

  Future<Response> putData(String path, Map<String, dynamic> body,
      Map<String, dynamic>? headers) async {
    try {
      Response response = await _dio
          .put(
            _baseUrl + path,
            data: jsonEncode(body),
            options: Options(headers: headers ?? mainHeaders),
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } catch (e) {
      print(e.toString());
      return Response(
        statusCode: 1,
        requestOptions: RequestOptions(
          headers: headers,
          baseUrl: _baseUrl + path,
        ),
      );
    }
  }

  Future<Response> getData(String path, Map<String, dynamic>? headers) async {
    try {
      Response response = await _dio
          .get(
            _baseUrl + path,
            options: Options(headers: headers ?? mainHeaders),
          )
          .timeout(const Duration(seconds: 50));
      return response;
    } catch (e) {
      print(e.toString());
      return Response(
        statusCode: 1,
        requestOptions: RequestOptions(
          headers: headers,
          baseUrl: _baseUrl + path,
        ),
      );
    }
  }

  Future<Response> getDataWithParams(String path, Map<String, dynamic>? headers,
      Map<String, dynamic>? params) async {
    try {
      Response response = await _dio
          .get(
            _baseUrl + path,
            options: Options(headers: headers ?? mainHeaders),
            queryParameters: params,
          )
          .timeout(const Duration(seconds: 50));
      return response;
    } catch (e) {
      print(e.toString());
      return Response(
        statusCode: 1,
        requestOptions: RequestOptions(
          headers: headers,
          baseUrl: _baseUrl + path,
        ),
      );
    }
  }
}
