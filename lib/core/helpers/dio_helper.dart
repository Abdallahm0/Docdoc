import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DioHelper {
  static late Dio _dio;
  static bool _isInitialized = false;

  static const String _authTokenKey = 'auth_token';

  static String formatAppointment(DateTime dateTime) {
    return DateFormat("EEEE, MMMM d, y h:mm a", "en_US").format(dateTime);
  }



  static Future<void> init({String baseUrl = 'https://vcare.integration25.com/api'}) async {
    if (_isInitialized) return;

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getAuthToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            print("Auth token attached");
          }
          print(" ${options.method} ${options.uri}");
          return handler.next(options);
        },
        onError: (e, handler) async {
          print(" Error: ${e.response?.statusCode} ${e.message}");
          if (e.response?.statusCode == 401) {
            await clearAuthToken();
            print("Token expired -> cleared");
          }
          return handler.next(e);
        },
      ),
    );


    _isInitialized = true;
    print("DioHelper initialized");
  }

  static Dio get dio {
    if (!_isInitialized) {
      throw Exception("DioHelper not initialized. Call init() first.");
    }
    return _dio;
  }


  static Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  static Future<bool> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_authTokenKey, token);
  }

  static Future<bool> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_authTokenKey);
  }

  static Future<bool> hasAuthToken() async {
    final token = await _getAuthToken();
    return token != null && token.isNotEmpty;
  }

  static Future<Response> get(String path, {Map<String, dynamic>? query}) async =>
      await dio.get(path, queryParameters: query);

  static Future<Response> post(String path, {dynamic data}) async =>
      await dio.post(path, data: data);

  static Future<Response> put(String path, {dynamic data}) async =>
      await dio.put(path, data: data);

  static Future<Response> delete(String path, {dynamic data}) async =>
      await dio.delete(path, data: data);

  static bool isSuccess(Response response) =>
      response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300;
}