import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../data/movie_model.dart';
import 'similar_movies_widget.dart';

class MovieWidget extends HookWidget {
  final MovieModel movie;

  const MovieWidget({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final likedMoviesState = useState<bool>(false);
    return Stack(
      children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(1),
                Colors.black.withOpacity(.65),
              ],
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      likedMoviesState.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      likedMoviesState.value = !likedMoviesState.value;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    movie.likesString,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 30),
                  const Icon(
                    Icons.star,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Popularity: ${movie.popularity}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    final similarMovie = movie.similarMovies[index];
                    return SimilarMovieWidget(
                      similarMovie: similarMovie,
                    );
                  },
                  itemCount: movie.similarMovies.length,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

