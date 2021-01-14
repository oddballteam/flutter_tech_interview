import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Store/marvel_store.dart';

class DetailView extends StatelessWidget {
  DetailView({Key key, this.characterId}) : super(key: key);

  int characterId;
  bool hasUpdated = false;

  EdgeInsets padding = const EdgeInsets.only(top: 15);

  @override
  Widget build(BuildContext context) {
    var marvelStore = context.watch<MarvelStore>();
    if (!hasUpdated) {
      marvelStore.getCharacterWith(characterId);
      hasUpdated = true;
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "${marvelStore.character.data.results.first.name}",
                      style: TextStyle(fontSize: 35),
                      maxLines: 3,
                    ),
                  ),
                  Text("ID: ${characterId ?? "0"}"),
                ],
              ),
            ),
            Flexible(
              child: Text("${marvelStore.character.data.results.first.description}"),
            ),
            Padding(
              padding: padding,
              child: Text("Number of comics: ${marvelStore.character.data.results.first.comics.items.length}"),
            ),
            Padding(
              padding: padding,
              child: Text("Number of stories: ${marvelStore.character.data.results.first.stories.items.length}"),
            ),
            Padding(
              padding: padding,
              child: Text("Number of events: ${marvelStore.character.data.results.first.events.items.length}"),
            )
          ],
        ),
      ),
    );
  }
}
