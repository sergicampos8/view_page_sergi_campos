import 'gif_model.dart';
import 'gif_detail_page.dart';
import 'package:flutter/material.dart';

class GifCard extends StatefulWidget {
  final GifSearchResult gifSearchResult;

  const GifCard(this.gifSearchResult, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _GifCardState createState() => _GifCardState(gifSearchResult);
}

class _GifCardState extends State<GifCard> {
  GifSearchResult gifSearchResult;
  String? renderUrl;

  _GifCardState(this.gifSearchResult);

  @override
  void initState() {
    super.initState();
    renderUrl = gifSearchResult.gifUrl;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showGifDetailPage(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5.0,
        margin: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[            // Imagen GIF
            Hero(
              tag: gifSearchResult,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(renderUrl ?? ''),
                  ),
                ),
              ),
            ),

            // Detalles de GIF
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      gifSearchResult.title ?? 'No Title',
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 4.0),
                        Text('${gifSearchResult.rating}/10'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showGifDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return GifDetailPage(gifSearchResult);
    }));
  }
}
