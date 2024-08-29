import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/movie/presentation/pages/home_screen/widgets/movie_by_genre_widget.dart';
import 'package:movie_app/features/movie/presentation/pages/home_screen/widgets/popular_movies_widget.dart';

import '../../../../../core/utils/colors.dart';
import '../../../domain/entities/movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    //use for bloc
    // BlocProvider.of<MovieBloc>(context).add(FetchPopularMovieEvent());
    // context.read<MovieBloc>().add(FetchPopularMovieEvent());

    //use for stream provider
    // final movieState = context.watch<MovieState>();
    //nếu dùng context.watch thì sẽ build lại toàn bộ ui trong hàm build (tức là hàm này)
    //nếu dùng context.read thì chỉ lấy giá trị hiện tại mà không listen provider
    //nếu dùng consumer thì chỉ update lại ui trong hàm build của consumer mỗi khi data của provider đó thay đổi

    /*
      StreamProvider sẽ thông báo tất cả widget con đã subscribe provider đó, nên dùng cho nhiều widget cùng listen một stream
      StreamBuilder nên dùng cho một widget cụ thể muốn listen một stream
     */

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 18
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello there',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28
                          ),
                        ),
                        Text(
                          'What to watch?',
                          style: TextStyle(
                              color: Colors.white54
                          ),)
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/avatar.jpg'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 50,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xff292b37),
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                          color: Colors.white54
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: const Divider(
                  color: Colors.white24,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
              ),
              const PopularMoviesWidget(),
              const MovieByGenreWidget()
            ]
        ),
      ),
    );
  }
}

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Expanded(child: Container(color: Colors.red,))
          ],
        )
      ],
    );
  }
}


