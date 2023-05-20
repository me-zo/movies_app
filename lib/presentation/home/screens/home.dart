import 'package:flutter/material.dart';
import 'package:movies_app/app/localization/resources.dart';
import 'package:movies_app/presentation/actions/screens/settings.dart';
import 'package:movies_app/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'movie_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    Future.microtask(
      () => Provider.of<HomeViewModel>(context, listen: false).searchMovies(
        keyword: "batman",
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Resources.of(context)
            .getResource("presentation.home.moviesHeader")),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Settings()),
            ),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, model, _) {
          if (model.isBusy) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        model.searchMovies(keyword: value);
                        _controller.clear();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: Resources.of(context)
                          .getResource("presentation.home.moviesSearch"),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Expanded(child: MovieList())
              ],
            ),
          );
        },
      ),
    );
  }
}
