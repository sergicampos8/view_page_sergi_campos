import 'gif_card.dart';
import 'package:flutter/material.dart';
import 'gif_model.dart';

class GifList extends StatelessWidget {
  final List<GifSearchResult> gifs;
  const GifList(this.gifs, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: gifs.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return GifCard(gifs[int]);
      },
    );
  }
}
