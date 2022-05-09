import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {

  String baseurl = "${dotenv.env['API_URL']}";
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future get(String url) async {
    String token = await storage.read(key: "token");
    print('******');
    print(token);
    url = formater(url);
    // /user/register
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }


  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    String token = await storage.read(key: "token");
      print('******');
      print(token);
    url = formater(url);
    log.d(body);
    var response = await http.post(
    url,
    headers:{'Content-Type': 'application/json',"Authorization": "Bearer $token"},
    body: json.encode(body));
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    String token = await storage.read(key: "token");
    print(token);
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }

  NetworkImage getImage(String imageName) {
    
    String url = formater("/uploads//$imageName.jpg");
  
  return NetworkImage(url);

    
  }
  
  String getCV(String CVName) {
    
  String url = formater("/resume//$CVName.pdf");

  return url;

  }

  Future<http.Response> patch(String url, Map<String, dynamic> body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  Future delete(String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    var response = await http.delete(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
   
    );
    return response;
  }

    Future<http.StreamedResponse> postCV(String url, String filepath) async {
    url = formater(url);
    String token = await storage.read(key: "token");
    print(token);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("pdfCV", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }


  String formater(String url) {
    return baseurl + url;
  }

}