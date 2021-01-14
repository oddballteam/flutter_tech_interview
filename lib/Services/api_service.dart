import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:tech_interview/Models/characters_model.dart';

class Helper {
  Future<Characters> makeHttpCall(Uri uri) async {
    Characters characterResponse = Characters();
    final response = await http.get(uri, headers: {});
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      print(json);
      characterResponse = Characters.fromJson(json);
    }
    print("${response.statusCode}: ${response.body}");
    return characterResponse;
  }
}
