import 'package:dio/dio.dart';
import 'package:fast_track/endpoints/endpoints.dart';
import 'package:fast_track/models/complaint.dart';
import 'package:fast_track/models/complaint_response.dart';
import 'package:fast_track/services/api/authenticationService/interceptors/exceptions/dio_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_key.dart';

class ComplaintClient {
  SharedPreferences? sharedPreferences;
  final String _baseUrl = EndPoints.complaintUrl;
  final String _locationUrl = EndPoints.locationUrl;

  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: EndPoints.complaintUrl,
        connectTimeout:
            const Duration(milliseconds: EndPoints.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: EndPoints.receiveTimeout),
        responseType: ResponseType.json),
  );
  Future<Response> addComplaint({required Complaint complaint}) async {
    Response response;
    try {
      // Retrieve token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('fast_token');

      if (token == null && token!.isEmpty) {
        throw Exception('Token not found');
      }
      final options = Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      response =
          await _dio.post(_baseUrl, data: complaint.toJson(), options: options);

      final responseData = response.data;
      if (response.statusCode == 200 &&
          responseData is Map<String, dynamic> &&
          responseData['error'] == false &&
          responseData['message'] == "Complaint created successfully") {
        return response;
      } else {
        throw Exception('Failed to create Complaint');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<ComplaintResponse> getConplaints(
      {required int perpage, required int page, String? search}) async {
    Response response;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('fast_token');

      if (token == null && token!.isEmpty) {
        throw Exception('Token not found');
      }
      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      response = await _dio.get(_baseUrl,
          queryParameters: {'per_page': perpage, 'page': page},
          options: options);

      if (response.statusCode == 200) {
        return ComplaintResponse.fromJson(response.data['data'][0]);
      } else {
        throw Exception('Failed to get Complaints');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> getLocation(
      {required double latitude, required double longitude}) async {
    Response response;
    try {
      final options = Options(
        headers: {
          'X-RapidAPI-Key':
          rapidApiKey,
          'X-RapidAPI-Host': 'geocodeapi.p.rapidapi.com'
        },
      );

      response = await _dio.get(
         _locationUrl ,
          queryParameters: {
            'range': '0',
            'longitude': longitude,
            'latitude': latitude
          },
          options: options);

      if (response.statusCode == 200) {
        print(response.data[0]["City"]);
        return response.data[0]["City"];
      } else {
        throw Exception('Failed to get Complaints');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
