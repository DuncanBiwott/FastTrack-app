import 'package:dio/dio.dart';
import 'package:fast_track/endpoints/endpoints.dart';
import 'package:fast_track/models/complaint.dart';
import 'package:fast_track/models/complaint_response.dart';
import 'package:fast_track/models/feedback.dart';
import 'package:fast_track/models/recommendation_response.dart';
import 'package:fast_track/services/api/authenticationService/interceptors/exceptions/dio_exception.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_key.dart';
import '../../../views/login/login_screen.dart';

class ComplaintClient {
  SharedPreferences? sharedPreferences;
  final String _baseUrl = EndPoints.complaintUrl;
  final String _locationUrl = EndPoints.locationUrl;
  final String _feedbackUrl = EndPoints.feedbackUrl;
  final String _profileUrl = EndPoints.profileUrl;
  final String _recommendationUrl = EndPoints.recommendationUrl;

  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: EndPoints.complaintUrl,
        connectTimeout:
            const Duration(milliseconds: EndPoints.connectionTimeout),
        receiveTimeout: const Duration(milliseconds: EndPoints.receiveTimeout),
        responseType: ResponseType.json),
  );
  Future<Response> addComplaint(
      {required Complaint complaint, required BuildContext? context}) async {
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
      } else if (response.statusCode == 401) {
        await prefs.remove('fast_token');

        Navigator.pushReplacement(
          context!,
          MaterialPageRoute(builder: (BuildContext context) => const Login()),
        );

        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to create Complaint');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Response> sendFeedBack(
      {required FeedbackRequest feedbackRequest,
      required BuildContext? context}) async {
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

      response = await _dio.post(_feedbackUrl,
          data: feedbackRequest.toJson(), options: options);

      final responseData = response.data;
      if (response.statusCode == 200 &&
          responseData is Map<String, dynamic> &&
          responseData['error'] == false &&
          responseData['message'] == "FeedBack Received Successfully") {
        return response;
      } else if (response.statusCode == 401) {
        await prefs.remove('fast_token');

        Navigator.pushReplacement(
          context!,
          MaterialPageRoute(builder: (BuildContext context) => const Login()),
        );

        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to send FeedBack');
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }


//Get All Complaints 
  Future<List<ComplaintResponse>> getComplaints({
    required int perPage,
    required int page,
    String? search,
    required BuildContext? context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('fast_token');

      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Response response = await _dio.get(
        _baseUrl,
        queryParameters: {'per_page': perPage, 'page': page, 'search': search},
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data["data"];
        List<ComplaintResponse> complaints = responseData
            .map((complaint) => ComplaintResponse.fromJson(complaint))
            .toList();
        return complaints;
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
      throw Exception(errorMessage);
    }
  }

  //Get Recommendations
  Future<List<RecommendationResponse>> getRecommendations({
    required int perPage,
    required int page,
    String? search,
    required BuildContext? context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('fast_token');

      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Response response = await _dio.get(
        _recommendationUrl,
        queryParameters: {'per_page': perPage, 'page': page, 'search': search},
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data["data"];
        List<RecommendationResponse> recommendation = responseData
            .map((recomm) => RecommendationResponse.fromJson(recomm))
            .toList();
        return recommendation;
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
      throw Exception(errorMessage);
    }
  }

//Get all Complaints Reports by User

Future<List<ComplaintResponse>> getUserReports({
    required int perPage,
    required int page,
    String? search,
    required BuildContext? context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('fast_token');

      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Response response = await _dio.get(
        EndPoints.userReportsUrl,
        queryParameters: {'per_page': perPage, 'page': page},
        options: options,
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data["data"];
        List<ComplaintResponse> complaints = responseData
            .map((complaint) => ComplaintResponse.fromJson(complaint))
            .toList();
        return complaints;
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
      throw Exception(errorMessage);
    }
  }




//Get user profile details
  Future<Response> getProfile({
    required BuildContext? context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('fast_token');

      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      final options = Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      Response response = await _dio.get(
        _profileUrl,
        options: options,
      );

      if (response.statusCode == 200) {
        print(response.data);
        return response;
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
      throw Exception(errorMessage);
    }
  }




//Get User Location from latitude and longitude using RapidApi
  Future<String> getLocation(
      {required double latitude, required double longitude}) async {
    Response response;
    try {
      final options = Options(
        headers: {
          'X-RapidAPI-Key': rapidApiKey,
          'X-RapidAPI-Host': 'geocodeapi.p.rapidapi.com'
        },
      );

      response = await _dio.get(_locationUrl,
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
