import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpodtutorial/services/http_service.dart';

import '../models/pokemon.dart';

final pokemonDataProvider =
    FutureProvider.family<Pokemon?, String>((ref, url) async {


  HTTPService _httpService = GetIt.instance.get<HTTPService>();

  Response? res = await _httpService.get(
    url,
  );
  if (res != null && res.data != null) {
    return Pokemon.fromJson(
      res.data!,
    );
  }
  return null;
});
