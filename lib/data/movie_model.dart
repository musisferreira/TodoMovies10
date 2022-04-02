import 'package:todo_movies10/data/similar_movie_model.dart';

class MovieModel {
  final int id;
  final String title;
  final String posterPath;
  final int voteCount;
  final double popularity;
  final List<SimilarMovieModel> similarMovies;

  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteCount,
    required this.popularity,
    required this.similarMovies,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['original_title'],
      posterPath: json['poster_path'],
      voteCount: json['vote_count'],
      popularity: json['popularity'],
      similarMovies: (json['similar']['results'] as List)
          .map((e) => SimilarMovieModel.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() =>
      'MovieModel(id: $id, title: $title, posterPath: $posterPath, voteCount: $voteCount, popularity: $popularity, similarMovies: $similarMovies)';

  String get likesString {
    if (voteCount == 0) {
      return 'No likes';
    } else if (voteCount == 1) {
      return '$voteCount Like';
    } else if (voteCount < 1000) {
      return '$voteCount Likes';
    } else {
      return '${(voteCount / 1000).toStringAsFixed(1)}K Likes';
    }
  }
}
