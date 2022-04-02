import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../data/similar_movie_model.dart';

class SimilarMovieWidget extends HookWidget {
  final SimilarMovieModel similarMovie;

  const SimilarMovieWidget({Key? key, required this.similarMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final similarMovieLikeState = useState<bool>(false);
    const _imageSize = 80.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: _imageSize,
            height: _imageSize * (16 / 9),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${similarMovie.posterPath}',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  similarMovie.title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  similarMovie.yearWithGenres,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              similarMovieLikeState.value = !similarMovieLikeState.value;
            },
            icon: Icon(
                similarMovieLikeState.value
                    ? Icons.check_circle
                    : Icons.check_circle_outlined,
                size: 14),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
