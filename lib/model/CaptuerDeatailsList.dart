import 'dart:convert';

import 'package:dgi/model/CaptureDetailsRequest.dart';

class CaptureDetailsList{
  final List<CaptureDetailsRequest> captureDetailsList;
  CaptureDetailsList(
      {required this.captureDetailsList});

  Map<String, Object?> toJson() {
    return {'Captures':jsonEncode(captureDetailsList)};
  }
}