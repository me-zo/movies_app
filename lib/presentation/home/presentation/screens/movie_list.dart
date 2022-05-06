import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/home_cubit.dart';

class MovieList extends StatelessWidget {

  const MovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is ShowMovieList) {
          return ListView.builder(
          itemCount: state.info.length,
          itemBuilder: (context, index) {
            final movie = state.info[index];

            return ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(movie.moviePoster)),
                    borderRadius: BorderRadius.circular(6)),
                width: 50,
                height: 100,
              ),
              title: Text(movie.movieTitle),
            );
          },
        );
        } else if (state is Error){
          return Center(child: Text(state.message),);
        } else if (state is Loading){
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return const Center(child: Text("Error Happened"),);
        }
      },
    );
  }
}
