import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:traveltales/features/User/Domain/user_model_new.dart';

abstract class Repository<T> {
  Repository({this.token, this.client});
  // final baseUrl = "http://localhost:8000/";
  final baseUrl = "http://10.0.2.2:8000/";
  // final baseUrl = "https://traveltales.loca.lt/";
  final endPoint = "api";

  late final Map<String, String> headers = {
    "Content-Type": "application/json",
    "x-access-token": token ?? ""
  };

  final String? token;
  final Client? client;

  T fromJson(String json);
  // String toJson(T model);
  List<T> listfromJson(String json);

  Future<List<T>> fetch(
      {Client? client, String path = "", String param = ""}) async {
    client ??= Client();

    final response = await client
        .get(Uri.parse(baseUrl + endPoint + path + param), headers: headers);

    return listfromJson(_handleStatusCode(response).body);
  }

  Future<List<T>> search({Client? client, required String query}) async {
    client ??= Client();

    final response = await client.post(
        Uri.parse(baseUrl + endPoint + "search?q=" + query),
        headers: headers);

    return listfromJson(_handleStatusCode(response).body);
  }

  Future<T> fetchOne({Client? client, required String id}) async {
    client ??= Client();

    final response =
        await client.get(Uri.parse("$baseUrl$endPoint/$id"), headers: headers);

    // if (response.statusCode == 200)
    return fromJson(_handleStatusCode(response).body);
  }

  Future<T> updateOne(
      {Client? client,
      required Map<String, dynamic> data,
      String id = ""}) async {
    client ??= Client();

    final response = await client.put(Uri.parse(baseUrl + endPoint + id),
        body: jsonEncode(data), headers: headers);

    // if (response.statusCode == 200)
    return fromJson(_handleStatusCode(response).body);
    // return null;
  }

  Future<T> blockOne({required String id}) async {
    final response = await (client ?? Client()).put(
      Uri.parse(baseUrl + endPoint + "blockUser/" + id),
      headers: headers,
    );
    return fromJson(_handleStatusCode(response).body);
  }

  Future<T> removeOne({Client? client, String id = ""}) async {
    client ??= Client();

    final response = await client.delete(Uri.parse("$baseUrl$endPoint$id"),
        headers: headers);

    // if (response.statusCode == 200)
    return fromJson(_handleStatusCode(response).body);
  }

  Future<T> deleteProfileUrl({Client? client}) async {
    client ??= Client();
    final response = await client
        .put(Uri.parse(baseUrl + endPoint + "deletePicture"), headers: headers);
    // if (response.statusCode == 200)
    return fromJson(_handleStatusCode(response).body);
  }

  Future<T> deleteImageFromGallery(
      {Client? client, required String imageUrl}) async {
    client ??= Client();

    final Map<String, dynamic> data = {
      'imageUrl': imageUrl,
    };

    final response = await client.put(
        Uri.parse(baseUrl + endPoint + "deleteImageFromGallery"),
        body: jsonEncode(data),
        headers: headers);
    // if (response.statusCode == 200)
    return fromJson(_handleStatusCode(response).body);
  }

  Future<T> deleteDestinationImage(
      {Client? client, required String imageUrl, required String id}) async {
    client ??= Client();

    final Map<String, dynamic> data = {
      'imageUrl': imageUrl,
    };

    final response = await client.put(
        Uri.parse(baseUrl + endPoint + "deleteDestinationImage/" + id),
        body: jsonEncode(data),
        headers: headers);
    // if (response.statusCode == 200)
    return fromJson(_handleStatusCode(response).body);
  }

  // Future<void> deleteImageFromGallery({required String imageUrl}) async {
  //   try {
  //     final Map<String, dynamic> data = {
  //       'currentPassword': imageUrl,
  //     };

  //     final response = await (client ?? Client()).put(
  //         Uri.parse("$baseUrl${endPoint}deleteImageFromGallery"),
  //         headers: headers,
  //         body: jsonEncode(data));
  //     _handleStatusCode(response, code: 200);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  Future<T> removeFavourite({Client? client, String id = ""}) async {
    client ??= Client();

    final response = await client.delete(
        Uri.parse(baseUrl + endPoint + "removeFromFavourites/" + id),
        headers: headers);

    // if (response.statusCode == 200)
    return fromJson(_handleStatusCode(response).body);
  }

  Future<T> add({required Map<String, dynamic> data, String path = ""}) async {
    final response = await (client ?? Client()).post(
      Uri.parse(baseUrl + endPoint + path),
      headers: headers,
      body: jsonEncode(data),
    );
    // print(response.body);

    // if (response.statusCode == 201)
    return fromJson(_handleStatusCode(response, code: 201).body);
  }

  Future<T> addToFavourite({required String id}) async {
    final response = await (client ?? Client()).put(
      Uri.parse(baseUrl + endPoint + "toggleFavourite/" + id),
      headers: headers,
    );
    return fromJson(_handleStatusCode(response).body);
    // return _handleStatusCode(response).body;
  }
  //required Map<String, dynamic> data,

  Future<void> changePassword(
      {required String currentPassword, required String newPassword}) async {
    try {
      final Map<String, dynamic> data = {
        'currentPassword': currentPassword,
        'newPassword': newPassword
      };

      final response = await (client ?? Client()).put(
          Uri.parse("$baseUrl${endPoint}changePassword"),
          headers: headers,
          body: jsonEncode(data));
      _handleStatusCode(response, code: 200);
    } catch (e) {
      throw e;
    }
  }

  uploadImage(String title, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(baseUrl + "/image"));

    request.fields['title'] = "testImage";

    var picture = http.MultipartFile.fromBytes('image',
        (await rootBundle.load('assets/images/aa.jpg')).buffer.asInt8List(),
        filename: 'aa.png');

    request.files.add(picture);

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var result = String.fromCharCodes(responseData);

    print(result);
  }

  // Future<T> changePassword(
  //     {required String oldPassword, required String newPassword}) async {
  //   final response = await (client ?? Client()).put(
  //     Uri.parse(baseUrl + endPoint + "changePassword/"),
  //     headers: headers,
  //     body: jsonEncode(newPassword),
  //   );
  //   return fromJson(_handleStatusCode(response).body);
  // }

  Response _handleStatusCode(
    Response response, {
    int code = 200,
  }) {
    if (response.statusCode == code) return response;

    if (response.statusCode == 402) {
      // print(response.body);
      return response;
    }

    final decodedResponse = jsonDecode(response.body);
    throw "${decodedResponse["message"]}";

    // throw "${response.statusCode}:${response.reasonPhrase}";
    // switch (response.statusCode) {
    //   case 400:
    //     throw "Bad Request";
    //   case 401:
    //     throw "Access Denied";
    //   case 403:
    //     throw "No Permission";
    //   case 405:
    //     throw "Method not allowed";
    //   case 429:
    //     throw "Too many requests";
    //   case 404:
    //     throw "Cannot find resource";
    //   case 500:
    //     throw "Internal Server Error";
    //   case 503:
    //     throw "Service Unavailable";
    //   default:
    //     throw "Oops! some error occured";
    // }
  }
}
