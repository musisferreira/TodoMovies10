import 'package:dio/dio.dart';
import 'package:todo_movies10/data/movie_model.dart';

import '../../data/genre_model.dart';


class HttpMoviesRequest {
  static final HttpMoviesRequest instance = HttpMoviesRequest();

  static const _apiKey = '93e375399b42f6f01b544bb80369394b';

  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
    ),
  );

  Future<MovieModel?> getMovies() async {
    try {
      final genres = await _getGenres();
      final response = await _dio.get(
        '/movie/157336',
        queryParameters: {
          'api_key': _apiKey,
          'append_to_response': 'similar',
        },
      );
      var data = response.data;
      for (int i = 0; i < data['similar']['results'].length; i++) {
        final ids = data['similar']['results'][i]['genre_ids'];
        final genresListId = genres.where((genre) => ids.contains(genre.id));
        data['similar']['results'][i]['genres'] =
            genresListId.map((e) => e.name).toList();
      }
      await Future.delayed(const Duration(seconds: 1));
      return MovieModel.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  Future<List<GenreModel>> _getGenres() async {
    final response = await _dio.get(
      '/genre/movie/list',
      queryParameters: {
        'api_key': _apiKey,
      },
    );
    return response.data['genres']
        .map<GenreModel>(
          (genre) => GenreModel.fromJson(genre),
        )
        .toList();
  }
}
