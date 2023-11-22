import 'gif_model.dart';
import 'package:flutter/material.dart';

class AddGifFormPage extends StatefulWidget {
  const AddGifFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddGifFormPageState createState() => _AddGifFormPageState();
}

class _AddGifFormPageState extends State<AddGifFormPage> {
  TextEditingController searchController = TextEditingController();
  List<GifSearchResult> searchResults = [];

  void searchGifs() async {
    var results = await GifSearchResult.searchGifs(searchController.text, limit: 10);
    setState(() {
      searchResults = results;
    });
  }

  void selectGif(GifSearchResult gif) {
    Navigator.of(context).pop(gif);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Gif'),
      ),
      body: Column(
        children: <Widget>[
          // Campo de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search GIFs',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    searchGifs();
                  },
                ),
              ),
            ),
          ),
          // Lista de resultados
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(searchResults[index].gifUrl ?? ''),
                  title: Text(searchResults[index].title ?? ''),
                  onTap: () => selectGif(searchResults[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
