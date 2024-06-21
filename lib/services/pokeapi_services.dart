import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokeApiService {
  final String apiUrl = 'https://pokeapi.co/api/v2/pokemon?limit=100';

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      List<Pokemon> pokemons = [];

      for (var item in data) {
        final pokeDetailResponse = await http.get(Uri.parse(item['url']));
        if (pokeDetailResponse.statusCode == 200) {
          pokemons.add(Pokemon.fromJson(json.decode(pokeDetailResponse.body)));
        }
      }
      return pokemons;
    } else {
      throw Exception('Failed to load Pokemons');
    }
  }
}
