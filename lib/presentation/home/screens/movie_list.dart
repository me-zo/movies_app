import 'package:flutter/material.dart';
import 'package:movies_app/presentation/home/home_view_model.dart';
import 'package:movies_app/presentation/home/screens/movie_details.dart';
import 'package:movies_app/presentation/route_generator.dart';
import 'package:provider/provider.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, model, _) {
        if (model.failure.hasError) {
          return Center(
            child: Text(
              model.failure.failure.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (model.movies.isNotEmpty) {
          return ListView.builder(
            itemCount: model.movies.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  model.getMovieDetails(id: model.movies[index].imdbID);
                  Navigator.of(context).push(
                    FadePageRoute(
                      builder: (_) => const MovieDetails(),
                    ),
                  );
                },
                contentPadding: const EdgeInsets.all(10),
                leading: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: model.isProfileLoaded[index]
                            ? NetworkImage(model.movies[index].poster)
                            : Image.asset("assets/images/logo.png").image,
                        onError: (_, __) {
                          setState(() {
                            model.isProfileLoaded[index] = false;
                          });
                        },
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  width: 50,
                  height: 100,
                ),
                title: Text(model.movies[index].title),
                subtitle: Text(model.movies[index].year),
              );
            },
          );
        } else {
          return const Center(
            child: Text("No movies available."),
          );
        }
      },
    );
  }
}
