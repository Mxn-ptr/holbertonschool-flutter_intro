import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EpisodesScreen extends StatelessWidget {
  final int id;

  const EpisodesScreen({super.key, required this.id});

  Future<List<String>> fetchEpisodes(int id) async {
    try {
      var url = Uri.https("rickandmortyapi.com", "api/character/$id");
      final response = await http.get(url);
      final body = jsonDecode(response.body);
      final episodes = body['episode'];
      final List<String> episodesName = [];
      for (var episode in episodes) {
        final episodeRes = await http.get(Uri.parse(episode));
        final episodeData = jsonDecode(episodeRes.body);
        episodesName.add(episodeData['name']);
      }
      return episodesName;
    } catch(err) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchEpisodes(id),
        builder:(context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator()
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else  {
            var episodes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: episodes.length,
              itemBuilder:(context, index) {
                return ListTile(
                  title: Text(episodes[index]),
                );
              },
            );
          }
        },
        ),
    );
  }
}
