import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/domain/entities/genre.dart';

class GenreLabelWidget extends StatelessWidget {
  List<Genre> genreList;
  List<int> genreIDList;
  GenreLabelWidget({super.key, required this.genreList, required this.genreIDList});

  @override
  Widget build(BuildContext context) {
    List<Widget> genreLabelList = [];

    for (final genreID in genreIDList) {
      for (final genre in genreList) {
        if (genre.id == genreID) {
          genreLabelList.add(
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: Colors.white54,
                          width: 1
                      )
                  ),
                  child: Text(genre.name, style: TextStyle(color: Colors.white54),)
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
