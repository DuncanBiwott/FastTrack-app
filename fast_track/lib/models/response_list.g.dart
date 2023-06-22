// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseList _$ResponseListFromJson(Map<String, dynamic> json) => ResponseList(
      data: json['data'] as List<dynamic>?,
      totalPages: json['totalPages'] as int?,
      totalItemsInPage: json['totalItemsInPage'] as int?,
      totalElements: json['totalElements'] as int?,
    );

Map<String, dynamic> _$ResponseListToJson(ResponseList instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalPages': instance.totalPages,
      'totalItemsInPage': instance.totalItemsInPage,
      'totalElements': instance.totalElements,
    };
