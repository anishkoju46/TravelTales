import 'package:http/http.dart' as http;

abstract class Repository<T> {
  final apiUrl = "http://localhost:8000/";
  final endPoint = "endpoint";
  Repository();

  List<T> listFromJson(String json);

  T fromJson(String json);

  Future<List<T>> fetch({required http.Client client}) async {
    final response = await (client).get(Uri.parse(apiUrl + endPoint));
    if (response.statusCode == 200) {
      //success
      final users = listFromJson(response.body);
      return users;
    }
    throw ("${response.statusCode} ${response.reasonPhrase}");
  }

  Future<T> fetchOne({required String id, required http.Client client}) async {
    final response =
        await (client).get(Uri.parse("$apiUrl$endPoint$id"));
    if (response.statusCode == 200) {
      final user = fromJson(response.body);
      return user;
    }
    throw ("${response.statusCode} ${response.reasonPhrase}");
  }

}
