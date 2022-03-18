import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseurl = "http://192.168.1.3:5000";
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future get(String url) async {
    url = formater(url);
    // /user/register
    var response = await http.get(
      url,
      headers: {},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patch(String url, Map<String, String> body) async {
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      url,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> post1(String url, var body) async {
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(body),
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(int id,String url, String filepath) async {
    url = formater(url);
    
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("image", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      
    });
    var response = request.send();
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater("/uploads//$imageName.jpg");
    return NetworkImage(url);
  }
}