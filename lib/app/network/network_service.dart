import 'dart:developer' show log;

import 'package:architecture_template_v1/app/network/logger_interceptor.dart';
import 'package:architecture_template_v1/app/network/network_type_enum.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:grock/grock.dart';

final class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  static NetworkService get instance => _instance;

  static late Dio _dio;

  /// main.dart initialize BaseOptions
  ///
  /// ```dart
  /// void main() {
  ///   NetworkService.instance.init(
  ///     baseUrl: 'https://jsonplaceholder.typicode.com',
  ///     connectTimeout: 5000,
  ///     receiveTimeout: 3000,
  ///     setAuthorizationToken: () async {
  ///       final tokenValue = await getToken();
  ///       final mapData = {"Authorization": "Bearer $tokenValue"};
  ///       return mapData;
  ///     },
  ///   );
  ///   runApp(MyApp());
  /// }
  /// ```
  ///
  /// and use Api Request
  /// ----------------- request example -----------------
  /// ```dart
  /// final request = await NetworkService.request(
  ///  method: NetworkType.get,
  ///  path: '/posts',
  ///  queryParameters: {"userId": 1},
  /// ).responseHandler(
  ///   success: (response) => Model.fromJson(response.data),
  ///   error: (err) => Toast.show(err.toString()),
  ///   loading: () => print("loading"),
  ///   done: () => print("done"),
  /// );
  /// ```
  ///
  Future<void> init({
    /// optionally you can add your own Dio
    Dio? dio,

    /// added required String baseUrl,
    required String baseUrl,

    /// added milliseconds
    int? connectTimeout,

    /// added milliseconds
    int? receiveTimeout,

    /// added headers
    Map<String, dynamic>? headers,

    /// added queryParameters
    Map<String, dynamic>? queryParameters,

    /// optionally you can add your own BaseOptions
    Options? request,

    /// async get token and headers add token
    /// ```dart
    /// void main() async {
    ///  WidgetsFlutterBinding.ensureInitialized();
    ///  await NetworkService.instance.init(
    ///   baseUrl: 'https://jsonplaceholder.typicode.com',
    ///   setAuthorizationToken: () async {
    ///     final tokenValue = await getToken();
    ///     final mapData = {"Authorization": "Bearer $tokenValue"};
    ///     return mapData;
    ///   },
    /// );
    /// runApp(MyApp());
    /// ```
    Future<Map<String, dynamic>?> Function()? setAuthorizationToken,

    /// or set BaseOptions
    BaseOptions? options,
  }) async {
    if (setAuthorizationToken != null) {
      final token = await setAuthorizationToken();
      if (token != null) {
        (headers ??= {}).addAll(token);
      }
    }
    _dio = dio ??
        Dio(
          options ??
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: connectTimeout?.milliseconds,
                receiveTimeout: receiveTimeout?.milliseconds,
                headers: headers,
                queryParameters: queryParameters,
                responseType: ResponseType.json,
                contentType: Headers.jsonContentType,
                validateStatus: (status) => status! < 500,
              ),
        );

    if (kDebugMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
  }

  /// ----------------- request example -----------------
  /// ```dart
  /// final request = await NetworkService.request(
  ///  method: NetworkType.get,
  ///  path: '/posts',
  ///  queryParameters: {"userId": 1},
  ///  isLogger: true,
  /// ).responseHandler(
  ///   success: (response) => Model.fromJson(response.data),
  ///   error: (err) => Toast.show(err.toString()),
  ///   loading: () => print("loading"),
  ///   done: () => print("done"),
  /// );
  /// ```
  ///
  static Future<Response> request({
    NetworkType method = NetworkType.get,
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    try {
      final dio = _dio;
      final result = switch (method) {
        NetworkType.get => dio.get,
        NetworkType.post => dio.post,
        NetworkType.put => dio.put,
        NetworkType.delete => dio.delete,
        NetworkType.patch => dio.patch,
      };
      return await result(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      return e.response!;
    } catch (e) {
      rethrow;
    }
  }
}

extension DioExtension on Future<Response> {
  Future<T?> responseHandler<T>(
      {T Function(Response response)? success,
      void Function(dynamic err)? error,
      void Function()? loading,
      void Function()? done}) async {
    try {
      loading?.call();
      final response = await this;
      if (response.statusCode == 200) {
        done?.call();
        return success?.call(response);
      } else {
        done?.call();
        throw DioException(
          requestOptions: response.requestOptions,
          type: DioExceptionType.badResponse,
          response: response,
          error: response.data,
          message: response.statusMessage,
          stackTrace: StackTrace.current,
        );
      }
    } on DioException catch (e) {
      log("Error: ${e.error}, Response: ${e.response}, Message: ${e.message}, StackTrace: ${e.stackTrace}, RequestOptions: ${e.requestOptions}, Type: ${e.type}",
          name: "DioException Error");
      if (e.response?.data != null) {
        error?.call(e.response?.data);
        throw Exception(e.response?.data);
      } else {
        error?.call(e.error);
        throw Exception(e.response?.statusMessage);
      }
    } catch (e) {
      log("Error: $e", name: "Catch Error");
      error?.call(e);
      throw Exception(e);
    }
  }
}
