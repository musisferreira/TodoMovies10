

class SimilarMovieModel {
  final int id;
  final String title;
  final String posterPath;
  final int releaseYear;
  final List<String> genres;

  SimilarMovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseYear,
    required this.genres,
  });

  factory SimilarMovieModel.fromJson(Map<String, dynamic> json) {
    return SimilarMovieModel(
      id: json['id'],
      title: json['original_title'],
      posterPath: json['poster_path'],
      releaseYear: int.parse(json['release_date'].substring(0, 4)),
      genres: (json['genres'] as List).cast<String>(),
    );
  }

  @override
  String toString() {
    return 'SimilarMovieModel{id: $id, title: $title, posterPath: $posterPath, releaseYear: $releaseYear, genres: $genres}';
  }

  String get yearWithGenres {
    return '$releaseYear - ${genres.join(', ')}';
  }
}
