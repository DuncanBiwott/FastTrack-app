import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fast_track/endpoints/endpoints.dart';
import 'package:fast_track/services/api/authenticationService/interceptors/exceptions/dio_exception.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/incidents_response.dart';

class IncidentClient {
  SharedPreferences? sharedPreferences;
  final String _baseUrl = EndPoints.incidentUrl;

  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: EndPoints.incidentUrl,
        connectTimeout:
            const Duration(milliseconds: EndPoints.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: EndPoints.receiveTimeout),
        responseType: ResponseType.json),
  );

  Future<IncidentResponse> getAllIncidents(
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
        return IncidentResponse.fromJson(response.data['data'][0]);
      } else {
        throw Exception('Failed to get Complaints');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response?> reportIncident(
      String title,
      String description,
      DateTime submissionDateTime,
      String location,
      String status,
      List<File> images) async {
    Response response;
    try {
      // Retrieve token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('fast_token');

      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';
      _dio.options.headers['Accept'] = 'application/json';

      var incidentRequest = {
        "title": title,
        "description": description,
        "submissionDateTime": submissionDateTime.toIso8601String(),
        "location": location,
        "status": status
      };

      FormData formData;

      if (images.isEmpty) {
        formData = FormData.fromMap({
          "incidentRequest": MultipartFile.fromString(
            jsonEncode(incidentRequest),
            contentType: MediaType.parse("application/json"),
          ),
        });
      } else if (images.length == 1) {
        formData = FormData.fromMap({
          "incidentRequest": MultipartFile.fromString(
            jsonEncode(incidentRequest),
            contentType: MediaType.parse("application/json"),
          ),
          "file": await MultipartFile.fromFile(images[0].path,
              filename: images[0].path.split('/').last),
        });
      } else {
        formData = FormData.fromMap({
          "incidentRequest": MultipartFile.fromString(
            jsonEncode(incidentRequest),
            contentType: MediaType.parse("application/json"),
          ),
          "files": [
            for (int i = 0; i < images.length; i++)
              await MultipartFile.fromFile(images[i].path,
                  filename: images[i].path.split('/').last),
          ],
        });
      }

      response = await _dio.post(_baseUrl,
          data: formData, options: Options(contentType: 'multipart/form-data'));

      final responseData = response.data;
      if (response.statusCode == 200 &&
          responseData is Map<String, dynamic> &&
          responseData['error'] == false &&
          responseData['message'] == "Incident created successfully") {
        return response;
      } else {
        throw Exception('Failed to submit Incident');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
