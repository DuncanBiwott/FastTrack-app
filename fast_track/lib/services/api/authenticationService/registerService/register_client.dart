import 'package:dio/dio.dart';
import 'package:fast_track/endpoints/endpoints.dart';
import 'package:fast_track/models/register_request.dart';
import 'package:fast_track/services/api/authenticationService/interceptors/exceptions/dio_exception.dart';

import '../interceptors/application_interceptor.dart';

class RegisterDioClient {

  final String _baseUrl=EndPoints.registerUrl;
  final options = Options(
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );
  final Dio _dio = Dio(
  
    BaseOptions(
      baseUrl: EndPoints.registerUrl,
      connectTimeout: const Duration(milliseconds: EndPoints.connectionTimeout),
      receiveTimeout: const Duration(milliseconds: EndPoints.receiveTimeout),
      responseType: ResponseType.json
    ),
  )..interceptors.add(AppInterceptors());

Future<Response>register({required UserRequest userDetails})async{
  Response response;
  try{
     response=await _dio.post(_baseUrl,
    data: userDetails.toJson(),
    options: options
    );

     final responseData = response.data;
    if (response.statusCode == 200 &&
        responseData is Map<String, dynamic> &&
        responseData['error'] == false &&
        responseData['message'] == "User registered Successfully!") {
      return response;
    } else {
      throw Exception('Failed to register user');
    }

  }on DioError catch(e){
    final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
  }
}


Future<Response>forgotPass({required String  token})async{
  Response response;
  try{
     response=await _dio.post(EndPoints.forgortPassUrl,
    data: token,
    options: options
    );

     final responseData = response.data;
    if (response.statusCode == 200 &&
        responseData is Map<String, dynamic> &&
        responseData['error'] == false &&
        responseData['message'] == "PASSWORD CHANGED SUCCESSFULLY") {
      print('Response Data $responseData');
      return response;
    } else {
      throw Exception('Failed to Reset Password');
    }

  }on DioError catch(e){

    final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
  }
}

}