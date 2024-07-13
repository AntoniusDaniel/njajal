class Pokemon {
  final String name;
  final String imageUrl;

  Pokemon({required this.name, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'] ?? 'Unknown', // Handle null values
      imageUrl: json['sprites']['other']['official-artwork']['front_default'] ??
          '', // Adjust this based on API response structure
    );
  }
}
