import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokepedia/models/pokemon.dart';

Future<List<Pokemon>> fetchPokemons() async {
  final response =
      await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body)['results'];

    // Fetch details for each Pokemon
    List<Pokemon> pokemons = [];
    for (var item in data) {
      final detailResponse = await http.get(Uri.parse(item['url']));
      if (detailResponse.statusCode == 200) {
        pokemons.add(Pokemon.fromJson(jsonDecode(detailResponse.body)));
      }
    }
    return pokemons;
  } else {
    throw Exception('Failed to load Pokémons');
  }
}
