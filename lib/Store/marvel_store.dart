import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tech_interview/Models/characters_model.dart';
import 'package:tech_interview/Models/keys.dart';
import 'package:tech_interview/Services/api_service.dart';
import 'package:crypto/crypto.dart' as crypto;

class MarvelStore with ChangeNotifier {
  final baseUrl = "gateway.marvel.com";
  final _helper = Helper();

  Characters _characters = Characters();
  Characters get characters => _characters;

  Future<void> getListOfHeros() async {
    var ts = DateTime.now().toString();
    var hash = crypto.md5.convert(utf8.encode(ts + APIKeys.privateKey + APIKeys.publicKey)).toString();

    final queryParams = {
      "apikey": APIKeys.publicKey,
      "ts": ts,
      "hash": hash,
      "limit": "50",
    };

    final getUri = Uri.https(baseUrl, '/v1/public/characters', queryParams);
    _characters = await _helper.makeHttpCall(getUri);
    notifyListeners();
  }
}
