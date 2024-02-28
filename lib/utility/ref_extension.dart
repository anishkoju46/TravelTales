import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension HandleDebounceAndCancel on Ref {
  Future<http.Client> handleDebounceAndCancel() async {
    var dispose = false;
    onDispose(() {
      dispose = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    if (dispose) {
      throw "Cancel";
    }
    final client = http.Client();
    onDispose(() {
      client.close();
    });
    return client;
  }
}
