import 'package:flutter/material.dart';
import 'character_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<Character>> fetchBbCharacters() async {
    try {
      var url = Uri.https("rickandmortyapi.com", "api/character");
      final response = await http.get(url);
      final body = jsonDecode(response.body);
      final characters = List<Character>.from(body['results']
          .map((character) => Character.fromJson(character)));
      return characters;
    } catch (err) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty'),
      ),
      body: FutureBuilder<List<Character>> (
        future: fetchBbCharacters(),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else {
            var characters = snapshot.data ?? [];
            return GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return CharacterTile(character: characters[index]);
              });
          }
        },
      )
    );
  }
}
