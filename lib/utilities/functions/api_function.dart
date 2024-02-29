import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:family/utilities/functions/app_functions.dart';
import 'package:family/utilities/functions/status_request.dart';
class Crud {
  static final Crud _internal = Crud._();
  factory Crud() {
    return _internal;
  }
  Crud._();
  Future<Either<StatusRequest, Map<String, dynamic>>> post(
      String url, Map<String, dynamic> data) async {
    if (await AppFunctions().checkInternet()) {
      try {
        final response = await http
            .post(Uri.parse(url),
                body:data)
            .timeout(const Duration(minutes: 2));
          log(response.body.toString());
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responsebody = jsonDecode(response.body);
          log(responsebody.toString());
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } on TimeoutException {
        return const Left(StatusRequest.lateException);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> capturePost(
      String url, Map<String, dynamic> data, File file) async {
    if (await AppFunctions().checkInternet()) {
      try {
        // final dio = Dio();
        // final response = await dio.get('https://dart.dev');
        // log(response.data);
        final request = http.MultipartRequest("POST", Uri.parse(url));
        final length = await file.length();
        final stream = http.ByteStream(file.openRead());
        final multipartFile =
            http.MultipartFile('file', stream, length, filename: file.path);
        request.files.add(multipartFile);
        data.forEach((key, value) {
          request.fields[key] = value.toString();
        });
        final respone = await request.send();
        final respones = await http.Response.fromStream(respone).timeout(const Duration(minutes: 2));
        log("110011${respones.body}");
        if (respones.statusCode == 200 || respones.statusCode == 201) {
          Map<String, dynamic> responsebody = jsonDecode(respones.body);
          
          return Right(responsebody);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } on TimeoutException {
        return const Left(StatusRequest.lateException);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }

  Future<Either<StatusRequest, Map<String, dynamic>>> get(String url) async {
    if (await AppFunctions().checkInternet()) {
      try {
        final response = await http
            .get(
              Uri.parse(url),
            )
            .timeout(const Duration(minutes: 2));
            log(response.body.toString());
        if (response.statusCode == 200) {
          Map<String, dynamic> mp = jsonDecode(response.body);
          log(mp.toString());
          //log(response.body.toString());
          return Right(mp);
        } else {
          return const Left(StatusRequest.serverfailure);
        }
      } on TimeoutException {
        return const Left(StatusRequest.lateException);
      }
    } else {
      return const Left(StatusRequest.offlinefailure);
    }
  }
}
