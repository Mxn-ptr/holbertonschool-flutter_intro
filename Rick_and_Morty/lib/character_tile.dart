import 'package:flutter/material.dart';
import 'package:flutter_application_2/episodes_screen.dart';
import 'models.dart';

class CharacterTile extends StatelessWidget {
  final Character character;

  const CharacterTile({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        title: Text(
          character.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
          )
        )
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EpisodesScreen(id: character.id)
            ));
        },
        child: Image.network(character.img, fit: BoxFit.cover),
      ),
    );
  }
}
