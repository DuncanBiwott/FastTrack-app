import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fast_track/endpoints/endpoints.dart';
import 'package:fast_track/models/event_response.dart';
import 'package:fast_track/services/api/authenticationService/interceptors/exceptions/dio_exception.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/incidents_response.dart';
import '../../../models/notification_response.dart';
import '../../../views/login/login_screen.dart';

class IncidentClient {
  SharedPreferences? sharedPreferences;
  final String _baseUrl = EndPoints.incidentUrl;
  final String _eventUrl = EndPoints.eventUrl;
  final String _notificationUrl = EndPoints.notificationUrl;
  final String _recommendationUrl= EndPoints.recommendationUrl;

  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: EndPoints.incidentUrl,
        connectTimeout:
            const Duration(milliseconds: EndPoints.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: EndPoints.receiveTimeout),
        responseType: ResponseType.json),
  );

  Future<List<IncidentResponse>> getAllIncidents(
      {required int perpage, required int page, String? search,required BuildContext? context}) async {
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
        final List<dynamic> responseData = response.data["data"];
         List<IncidentResponse> incidents = responseData.map((incident) => IncidentResponse.fromJson(incident)).toList();
      return incidents;
    }else if (response.statusCode == 401) {
    
      await prefs.remove('fast_token');

    Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
      );

      throw Exception('Unauthorized');
    }
     else {
      throw Exception('Failed to get Complaints');
    }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  //download Image
  Future<Uint8List> downloadImage({required int id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('fast_token');

    if (token == null || token.isEmpty) {
      throw Exception('Token not found');
    }

    final options = Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
      responseType: ResponseType.bytes,
    );

    Response<List<int>> response = await _dio.get(
      '$_baseUrl/download/$id',
      options: options,
    );

    return Uint8List.fromList(response.data!);
  }


    Future<List<EventResponse>> getAllEvents(
      {required int perpage, required int page, String? search,required BuildContext? context}) async {
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

      response = await _dio.get(_eventUrl,
          queryParameters: {'per_page': perpage, 'page': page},
          options: options);


      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data["data"];
         List<EventResponse> events = responseData.map((event) => EventResponse.fromJson(event)).toList();
      return events;
    }else if (response.statusCode == 401) {
    
      await prefs.remove('fast_token');

    Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
      );

      throw Exception('Unauthorized');
    }
     else {
      throw Exception('Failed to get Complaints');
    }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<EventResponse>> getAllEventsByCategory({
  String? search,
  String? category,
  required BuildContext? context,
}) async {
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

   

    response = await _dio.get(EndPoints.eventCategory,queryParameters: {"category":category}, options: options);

    if (response.statusCode == 200) {
      final List<dynamic> responseData = response.data["data"];
      List<EventResponse> events = responseData.map((event) => EventResponse.fromJson(event)).toList();
      return events;
    } else if (response.statusCode == 401) {
      await prefs.remove('fast_token');
      Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
      );
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to get Complaints');
    }
  } on DioError catch (e) {
    final errorMessage = DioExceptions.fromDioError(e).toString();
    throw errorMessage;
  }
}

  Future<List<NotificationResponse>> getAllNotifications(
      {required int perpage, required int page,required BuildContext? context}) async {
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

      response = await _dio.get(_notificationUrl,
          queryParameters: {'per_page': perpage, 'page': page},
          options: options);


      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data["data"];
         List<NotificationResponse> events = responseData.map((event) => NotificationResponse.fromJson(event)).toList();
      return events;
    }else if (response.statusCode == 401) {
    
      await prefs.remove('fast_token');

    Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
      );

      throw Exception('Unauthorized');
    }
     else {
      throw Exception('Failed to get Complaints');
    }
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
      List<File> images,
      BuildContext? context
      ) async {
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
      }else if (response.statusCode == 401) {
    
      await prefs.remove('fast_token');

    Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
      );

      throw Exception('Unauthorized');
    } else {
        throw Exception('Failed to submit Incident');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }


    Future<Response?> makeRecommendation(
      String title,
      String description,
      DateTime submissionDateTime,
      String location,
      String category,
      List<File> images,
      BuildContext? context
      ) async {
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

      var recommendationRequest = {
        "title": title,
        "description": description,
        "submissionDateTime": submissionDateTime.toIso8601String(),
        "location": location,
        "category": category
      };

      FormData formData;

      if (images.isEmpty) {
        formData = FormData.fromMap({
          "recommendationRequest": MultipartFile.fromString(
            jsonEncode(recommendationRequest),
            contentType: MediaType.parse("application/json"),
          ),
        });
      } else if (images.length == 1) {
        formData = FormData.fromMap({
          "recommendationRequest": MultipartFile.fromString(
            jsonEncode(recommendationRequest),
            contentType: MediaType.parse("application/json"),
          ),
          "file": await MultipartFile.fromFile(images[0].path,
              filename: images[0].path.split('/').last),
        });
      } else {
        formData = FormData.fromMap({
          "recommendationRequest": MultipartFile.fromString(
            jsonEncode(recommendationRequest),
            contentType: MediaType.parse("application/json"),
          ),
          "files": [
            for (int i = 0; i < images.length; i++)
              await MultipartFile.fromFile(images[i].path,
                  filename: images[i].path.split('/').last),
          ],
        });
      }

      response = await _dio.post(_recommendationUrl,
          data: formData, options: Options(contentType: 'multipart/form-data'));

      final responseData = response.data;
      if (response.statusCode == 200 &&
          responseData is Map<String, dynamic> &&
          responseData['error'] == false &&
          responseData['message'] == "Recommendation created successfully") {
        return response;
      }else if (response.statusCode == 401) {
    
      await prefs.remove('fast_token');

    Navigator.pushReplacement(
        context!,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
      );

      throw Exception('Unauthorized');
    } else {
        throw Exception('Failed to submit Incident');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
