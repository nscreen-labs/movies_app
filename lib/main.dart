import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'core/database/database.dart';
import 'home/controller/movie_controller.dart';
import 'home/pages/home_page.dart';
import 'home/repository/movie_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final getIt = GetIt.instance;

  getIt.registerLazySingleton(
    () => MovieController(
      cacheManager: DefaultCacheManager(),
      moviesDao: AppDatabase.instance.moviesDao,
      moviesRepository: MovieRepository(),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}
