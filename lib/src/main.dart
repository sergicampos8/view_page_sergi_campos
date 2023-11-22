import 'package:flutter/material.dart';
import 'dart:async';
import 'gif_model.dart';
import 'gif_list.dart';
import 'new_gif_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My fav Gifs by Sergi Campos',
      theme: ThemeData(
        primaryColor: const Color(0xFF304FFE), // Azul intenso
        hintColor: Colors.pinkAccent, // Rosa para acentos
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF0F0F0), // Fondo claro
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          bodyText1: TextStyle(color: Colors.black),
          // ignore: deprecated_member_use
          bodyText2: TextStyle(color: Colors.black87),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF304FFE), // Azul intenso para AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.pinkAccent, // Botones en rosa
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const MyHomePage(
        title: 'My fav Gifs by Sergi Campos',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GifSearchResult> initialGifs = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadInitialGifs());
  }

void _loadInitialGifs() async {
  var initialTerms = ['hola', 'surf', 'love'];
  List<GifSearchResult> loadedGifs = [];

  for (var term in initialTerms) {
    var results = await GifSearchResult.searchGifs(term, limit: 1);
    if (results.isNotEmpty) {
      loadedGifs.add(results.first);
    }
  }

  if (mounted) {
    setState(() {
      initialGifs = loadedGifs;
    });
  }
}
  Future _showNewGifForm() async {
    GifSearchResult newGif = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddGifFormPage();
    }));
    //print(newDigimon);
    initialGifs.add(newGif);
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0B479E),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showNewGifForm,
          ),
        ],
      ),
      body: Container(
          color: const Color.fromARGB(255, 88, 111, 137),
          child: Center(
            child: GifList(initialGifs),
          )),
    );
  }
}
