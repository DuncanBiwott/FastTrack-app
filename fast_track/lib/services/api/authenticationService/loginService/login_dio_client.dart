import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:fast_track/endpoints/endpoints.dart';
import 'package:fast_track/services/api/authenticationService/interceptors/exceptions/dio_exception.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/request_token.dart';
import '../../../../views/login/login_screen.dart';
import '../interceptors/application_interceptor.dart';

class LoginDioClient{
  final String _baseUrl=EndPoints.getTokeUrl;
  final options = Options(
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  final Dio _dio = Dio(
  
    BaseOptions(
      connectTimeout: const Duration(milliseconds: EndPoints.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: EndPoints.receiveTimeout),
      responseType: ResponseType.json
    ),
  )..interceptors.add(AppInterceptors());
Future<void> saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('fast_token', token);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('fast_token');
}

Future<void> deleteToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('fast_token');
}

Future<Response> login({required LoginRequest userDetails}) async {
  try {
    final response = await _dio.post(
      _baseUrl,
      data: userDetails.toJson(),
      options: options,
    );
    final token = response.data['token'];
      await saveToken(token);
      return response;
  } on DioError catch (e) {
    final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    
  }
}





Future<Response> logout(BuildContext context) async {
  try {
    String? token=await getToken();
    final response = await _dio.get(
      "$_baseUrl/logout/$token",
      options: options,
    );
    await deleteToken();
    // ignore: avoid_single_cascade_in_expression_statements
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
    message: 'Successfully logged out',
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.green,
  )..show(context).then((value) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
  
    });

   return response;
  // ignore: deprecated_member_use
  } on DioError catch (e) {
    
    final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
  }
}
}