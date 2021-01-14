import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Helper {
  Future<dynamic> makeHttpCall(Uri uri) async {
    final response = await http.get(uri, headers: {});
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      print(json);
      return json;
    }
    print("${response.statusCode}: ${response.body}");
  }
}
