import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../core/database/daos/movies_dao.dart';
import '../../core/database/database.dart';
import '../../core/utils/get_image_url.dart';
import '../models/movie_details.dart';
import '../repository/movie_repository.dart';

class MovieController {
  final MovieRepository _moviesRepository;

  final DefaultCacheManager _cacheManager;

  final MoviesDao _moviesDao;

  MovieController({
    required MovieRepository moviesRepository,
    required MoviesDao moviesDao,
    required DefaultCacheManager cacheManager,
  })  : _moviesRepository = moviesRepository,
        _moviesDao = moviesDao,
        _cacheManager = cacheManager;

  Future downloadImage(String url) async {
    final localFile = await _cacheManager.getFileFromCache(url);

    if (localFile != null) return;

    await _cacheManager.downloadFile(url);
  }

  Future<void> getMoviesFromRemote() async {
    final movies = await _moviesRepository.getMovies();

    if (movies == null) return;

    await _moviesDao.removeAll();

    for (var movie in movies) {
      downloadImage(getImageUrl(movie.posterPath ?? ''));
    }

    await _moviesDao.addAll(movies);
  }

  Stream<List<Movie>> getMoviesFromLocal() {
    return _moviesDao.getAll();
  }

  Future<List<Movie>?> getMovies() async {
    return _moviesRepository.getMovies();
  }

  Future<List<Movie>?> getSimilarMovies({required int movieId}) async {
    return _moviesRepository.getSimilarMovies(movieId: movieId);
  }

  Future<MovieDetails?> getMovieDetails(int id) async {
    return _moviesRepository.getMovieDetails(id);
  }
}
