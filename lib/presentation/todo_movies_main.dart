import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:todo_movies10/data/movie_model.dart';


import '../core/utils/http_request.dart';
import 'screens/movie_widget.dart';

class TodoMoviesMain extends HookWidget {
  const TodoMoviesMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesState = useState<MovieModel?>(null);
    final loadingState = useState<bool>(false);
    return Scaffold(
      body: Stack(
        children: [
          if (loadingState.value)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (moviesState.value == null && !loadingState.value)
            const Center(
              child: Text('Nenhum filme encontrado!'),
            ),
          if (moviesState.value != null && !loadingState.value)
            MovieWidget(movie: moviesState.value!),
          Positioned(
            child: IconButton(
              tooltip: 'Lista Filmes',
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                loadingState.value = true;
                moviesState.value =
                    await HttpMoviesRequest.instance.getMovies();
                loadingState.value = false;
              },
            ),
            top: 10,
            left: 10,
          ),
        ],
      ),
    );
  }
}

