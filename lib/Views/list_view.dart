import 'package:flutter/material.dart';
import 'package:tech_interview/Store/marvel_store.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var hasBeenSet = false;

  @override
  Widget build(BuildContext context) {
    var marvelStore = context.watch<MarvelStore>();
    setState(() {
      if (hasBeenSet) {
        return;
      } else {
        hasBeenSet = true;
        marvelStore.getListOfHeros();
      }
    });

    return Scaffold(
      body: Center(
        child: Container(
          child: marvelStore.characters.data == null
              ? CircularProgressIndicator()
              : ListView.separated(
                  itemCount: marvelStore.characters.data.count,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Image.network(marvelStore.characters.data.results[index].thumbnail.path),
                      title: Text(marvelStore.characters.data.results[index].name ?? "Unknown Name"),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                ),
        ),
      ),
    );
  }
}
