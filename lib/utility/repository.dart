import 'dart:convert';

import 'package:http/http.dart';

abstract class Repository<T> {
  Repository({this.token, this.client});
  // final baseUrl = "http://localhost:8000/";
  final baseUrl = "http://10.0.2.2:8000/";
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

    final response = await client.get(
        Uri.parse(
          "$baseUrl$endPoint/search?query=$query",
        ),
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
      {Client? client, required Map<String, dynamic> data}) async {
    client ??= Client();

    final response = await client.put(Uri.parse(baseUrl + endPoint),
        body: data, headers: headers);

    // if (response.statusCode == 200)
    return fromJson(_handleStatusCode(response).body);
    // return null;
  }

  Future<T> removeOne({Client? client, required String id}) async {
    client ??= Client();

    final response = await client.delete(Uri.parse("$baseUrl$endPoint/id"),
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

    // if (response.statusCode == 201)
    return fromJson(_handleStatusCode(response, code: 201).body);
  }

  Response _handleStatusCode(
    Response response, {
    int code = 200,
  }) {
    if (response.statusCode == code) return response;

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
