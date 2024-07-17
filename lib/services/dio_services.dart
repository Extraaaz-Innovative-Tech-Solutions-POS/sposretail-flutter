import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:spos_retail/constants/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DioServices {
  static Dio? _dio;

  static Dio get dio {
    _dio ??= Dio();

    _dio!.options.validateStatus = (status) {
      return status! < 500;
    };
    return _dio!;
  }

  static String host = AppConstant.baseUrl;

  static Future<Response> get(String endpoint,
      {Map<String, dynamic>? headers,
      uniqueToken,
      Map<String, dynamic>? queryParameters}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final url = "$host/$endpoint";
    final token = pref.getString("token");
    print(url);
    print(queryParameters);
    final header = {
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await dio.get(url,
          options: Options(headers: header), queryParameters: queryParameters);
      print(response.statusCode);
      return response;
    } catch (e) {
      print("this is the error $e");
      throw Exception('GET request failed: $e');
    }
  }

  static Future<Response> postRequest(String endpoint, dynamic data) async {
    final url = "$host/$endpoint";
    print(url);
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");
    print(jsonEncode(data));
    print("Bearer Token is : - $token");
    print(url);
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      //print(jsonEncode(data));
      final response = await dio.post(url,
          data: jsonEncode(data),
          options: Options(
              method: "POST",
              receiveDataWhenStatusError: false,
              headers: headers));
      return response;
    } catch (e) {
      print("error is $e");
      throw Exception('POST request failed: $e');
    }
  }

  static Future<Response> put(String endpoint, dynamic data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");
    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final url = "$host/$endpoint";
      final response = await dio.put(url,
          data: jsonEncode(data),
          options: Options(
              method: "POST",
              receiveDataWhenStatusError: true,
              headers: headers));
      return response;
    } catch (e) {
      throw Exception('PUT request failed: $e');
    }
  }

  static Future<Response> delete(
    String endpoint, {
    Map<String, dynamic>? headers,
    uniqueToken,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final url = "$host/$endpoint";
    final token = pref.getString("token");
    print(url);

    final header = {
      'Authorization': 'Bearer $token',
    };
    try {
      final response = await dio.delete(url, options: Options(headers: header));
      print(response.statusCode);
      return response;
    } catch (e) {
      print("this is the error ");
      throw Exception('GET request failed: $e');
    }
  }

  static dynamic dioResponseHandler(response) {
    Map<String, dynamic> responseData = json.decode(response.toString());
    return responseData;
  }
}
