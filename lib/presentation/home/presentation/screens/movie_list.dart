import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/home/presentation/manager/home_bloc.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is ShowMovieList) {
          return ListView.builder(
            itemCount: state.info.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => BlocProvider.of<HomeBloc>(context).add(
                  MovieDetailsEvent(id: state.info[index].imdbID),
                ),
                contentPadding: const EdgeInsets.all(10),
                leading: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: BlocProvider.of<HomeBloc>(context)
                                .isProfileLoaded[index]
                            ? NetworkImage(state.info[index].moviePoster)
                            : Image.asset("assets/images/logo.png").image,
                        onError: (_, __) {
                          setState(() {
                            BlocProvider.of<HomeBloc>(context)
                                .isProfileLoaded[index] = false;
                          });
                        },
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  width: 50,
                  height: 100,
                ),
                title: Text(state.info[index].movieTitle),
                subtitle: Text(state.info[index].year),
              );
            },
          );
        } else if (state is Error) {
          return Center(
            child: Text(state.message,
                style: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          );
        } else {
          return const Center(
            child: Text("Error Happened"),
          );
        }
      },
    );
  }
}
