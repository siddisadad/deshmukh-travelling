import 'dart:convert';
import 'package:flutter/material.dart';
import '../flutter_flow_util.dart';

extension ColorSerializationExt on Color {
  String serializeColor() => '#\${value.toRadixString(16).padLeft(8, "0")}';
}

enum ParamType {
  int,
  double,
  String,
  bool,
  DateTime,
  DateTimeRange,
  LatLng,
  Color,
  FFPlace,
  FFUploadedFile,
  JSON,
}

String? serializeParam(
  dynamic param,
  ParamType paramType, {
  bool isList = false,
}) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final List<String> serializedValues = (param as Iterable)
          .map((p) => serializeParam(p, paramType, isList: false))
          .where((p) => p != null)
          .map((p) => p!)
          .toList();
      return json.encode(serializedValues);
    }
    switch (paramType) {
      case ParamType.int:
        return param.toString();
      case ParamType.double:
        return param.toString();
      case ParamType.String:
        return param;
      case ParamType.bool:
        return param ? 'true' : 'false';
      case ParamType.DateTime:
        return (param as DateTime).millisecondsSinceEpoch.toString();
      case ParamType.DateTimeRange:
        return dateTimeRangeToString(param as DateTimeRange);
      case ParamType.LatLng:
        return (param as LatLng).serialize();
      case ParamType.Color:
        return (param as Color).serializeColor();
      case ParamType.FFPlace:
        return (param as FFPlace).serialize();
      case ParamType.FFUploadedFile:
        return (param as FFUploadedFile).serialize();
      case ParamType.JSON:
        return json.encode(param);
    }
  } catch (e) {
    print('Error serializing parameter: $e');
    return null;
  }
}

dynamic deserializeParam<T>(
  String? param,
  ParamType paramType,
  bool isList,
) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final paramValues = json.decode(param);
      if (paramValues is! Iterable || paramValues.isEmpty) {
        return null;
      }
      return paramValues
          .where((p) => p is String)
          .map((p) => p as String)
          .map((p) => deserializeParam<T>(p, paramType, false))
          .where((p) => p != null)
          .map((p) => p! as T)
          .toList();
    }
    switch (paramType) {
      case ParamType.int:
        return int.tryParse(param);
      case ParamType.double:
        return double.tryParse(param);
      case ParamType.String:
        return param;
      case ParamType.bool:
        return param == 'true';
      case ParamType.DateTime:
        return dateTimeFromString(param);
      case ParamType.DateTimeRange:
        return dateTimeRangeFromString(param);
      case ParamType.LatLng:
        return latLngFromString(param);
      case ParamType.Color:
        return colorFromCssString(param);
      case ParamType.FFPlace:
        return FFPlace.deserialize(param);
      case ParamType.FFUploadedFile:
        return FFUploadedFile.deserialize(param);
      case ParamType.JSON:
        return json.decode(param);
    }
  } catch (e) {
    print('Error deserializing parameter: $e');
    return null;
  }
}

DateTime? dateTimeFromString(String? dateTimeStr) {
  if (dateTimeStr == null || dateTimeStr.isEmpty) {
    return null;
  }
  return DateTime.fromMillisecondsSinceEpoch(int.parse(dateTimeStr));
}

String dateTimeRangeToString(DateTimeRange dateTimeRange) {
  final start = dateTimeRange.start.millisecondsSinceEpoch;
  final end = dateTimeRange.end.millisecondsSinceEpoch;
  return '$start|$end';
}

DateTimeRange? dateTimeRangeFromString(String dateTimeRangeStr) {
  final parts = dateTimeRangeStr.split('|');
  if (parts.length != 2) {
    return null;
  }
  return DateTimeRange(
    start: DateTime.fromMillisecondsSinceEpoch(int.parse(parts[0])),
    end: DateTime.fromMillisecondsSinceEpoch(int.parse(parts[1])),
  );
}

LatLng? latLngFromString(String latLngStr) {
  final parts = latLngStr.split(',');
  if (parts.length != 2) {
    return null;
  }
  return LatLng(double.parse(parts[0]), double.parse(parts[1]));
}

FFPlace placeFromString(String placeStr) => FFPlace.deserialize(placeStr);

FFUploadedFile uploadedFileFromString(String uploadedFileStr) =>
    FFUploadedFile.deserialize(uploadedFileStr);
