import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tech_interview/Models/character_model.dart';
import 'package:tech_interview/Models/characters_model.dart';
import 'package:tech_interview/Models/keys.dart';
import 'package:tech_interview/Services/api_service.dart';
import 'package:crypto/crypto.dart' as crypto;

import '../Models/characters_model.dart';

class MarvelStore with ChangeNotifier {
  final baseUrl = "gateway.marvel.com";
  final _helper = Helper();

  Characters _characters = Characters();
  Characters get characters => _characters;

  Character _character = Character();
  Character get character => _character;

  Map<String, String> setQueryParams(int limit) {
    var ts = DateTime.now().toString();
    var hash = crypto.md5.convert(utf8.encode(ts + APIKeys.privateKey + APIKeys.publicKey)).toString();

    final queryParams = {
      "apikey": APIKeys.publicKey,
      "ts": ts,
      "hash": hash,
      "limit": "$limit",
    };

    return queryParams;
  }

  Future<void> getListOfHeros() async {
    final getUri = Uri.https(baseUrl, '/v1/public/characters', setQueryParams(50));
    final _jsonResponse = await _helper.makeHttpCall(getUri);
    _characters = Characters.fromJson(_jsonResponse);
    notifyListeners();
  }

  Future<void> getCharacterWith(int id) async {
    final getUri = Uri.https(baseUrl, '/v1/public/characters/$id', setQueryParams(1));
    final _jsonResponse = await _helper.makeHttpCall(getUri);
    _character = Character.fromJson(_jsonResponse);
    notifyListeners();
  }
}
