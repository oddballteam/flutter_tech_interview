import 'package:flutter/material.dart';
import 'package:tech_interview/Store/marvel_store.dart';
import 'package:provider/provider.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
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
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: marvelStore.characters.data == null
              ? CircularProgressIndicator()
              : ListView.separated(
                  itemCount: marvelStore.characters.data.count,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
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
