import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/entities/genre.dart';

class GenreLabelWidget extends StatelessWidget {
  List<Genre> genreList;
  List<int> genreIDList;
  GenreLabelWidget({super.key, required this.genreList, required this.genreIDList});

  @override
  Widget build(BuildContext context) {
    List<Widget> genreLabelList = [];
    final colorScheme = Theme.of(context).colorScheme;

    for (final genreID in genreIDList) {
      for (final genre in genreList) {
        if (genre.id == genreID) {
          genreLabelList.add(
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: colorScheme.onSurface.withOpacity(0.5),
                          width: 1
                      )
                  ),
                  child: Text(genre.name,)
              )
          );
          break;
        }
      }
    }

    return Wrap(
        spacing: 8,
        runSpacing: 4,
        children: genreLabelList
    );
  }
}
