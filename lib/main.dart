import 'package:flutter/material.dart';
import 'models/pokemon.dart';
import 'services/pokeapi_services.dart';

void main() {
  runApp(PokemonPediaApp());
}

class PokemonPediaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Pedia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonListScreen(),
    );
  }
}

class PokemonListScreen extends StatefulWidget {
  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  late Future<List<Pokemon>> futurePokemons;

  @override
  void initState() {
    super.initState();
    futurePokemons = PokeApiService().fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon Pedia'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Pokemon>>(
          future: futurePokemons,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Failed to load Pokemons'));
            } else if (snapshot.hasData) {
              return GridView.builder(
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.75, // Ratio lebar dan tinggi item grid
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final pokemon = snapshot.data![index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10.0)),
                          child: Image.network(
                            pokemon.imageUrl,
                            fit: BoxFit.cover,
                            height: 120,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            pokemon.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No Pokemons found'));
            }
          },
        ),
      ),
    );
  }
}
