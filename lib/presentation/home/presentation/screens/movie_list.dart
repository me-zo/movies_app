import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/home_cubit.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late List<bool> loaded;
  @override
  void initState() {
    var state = BlocProvider.of<HomeCubit>(context).state;
   if ( state is ShowMovieList) {
        loaded = List.generate(state.info.length, (index) => true);
      } else {
     loaded = [];
   }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is ShowMovieList) {
          return ListView.builder(
            itemCount: state.info.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () =>
                    BlocProvider.of<HomeCubit>(context).getMovieDetails(
                  id: state.info[index].imdbID,
                ),
                contentPadding: const EdgeInsets.all(10),
                leading: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: loaded[index] ? NetworkImage(state.info[index].moviePoster) : Image.asset("assets/images/logo.png").image,
                        onError: (_, __) {
                          setState(() {loaded[index] = false;});
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
