import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/database/database.dart';
import '../../core/utils/get_image_url.dart';
import '../controller/movie_controller.dart';

class MovieCard extends StatelessWidget {
  MovieCard({super.key, required this.movie, this.onTap});
  final Movie movie;
  final Function()? onTap;

  final controller = GetIt.I.get<MovieController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    getImageUrl(
                      movie.posterPath ?? '',
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  movie.releaseDate ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Text(
            '${movie.title}\n',
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
