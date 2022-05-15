import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app/localization/resources.dart';
import 'package:movies_app/presentation/home/domain/models/movie_details_model.dart';
import 'package:movies_app/presentation/home/presentation/manager/home_bloc.dart';

class MovieDetails extends StatelessWidget {
  final MovieDetailsModel movie;

  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool rtl = (Directionality.of(context) == TextDirection.rtl);
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<HomeBloc>(context).add(SearchMoviesEvent());
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _BackgroundImage(url: movie.poster),
            _DetailsBody(movie: movie),
            Align(
              alignment: rtl ? Alignment.topRight : Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 28, horizontal: 5),
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.2),
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add(SearchMoviesEvent());
                    Navigator.of(context).pop();
                  },
                  mini: true,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundImage extends StatefulWidget {
  final String url;

  const _BackgroundImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<_BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<_BackgroundImage> {
  bool loaded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
          image: loaded
              ? NetworkImage(widget.url)
              : Image.asset("assets/images/logo.png").image,
          onError: (_, __) => setState(() {
            loaded = false;
          }),
        ),
      ),
      child: const SizedBox(
        width: double.infinity,
        height: 500,
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  final MovieDetailsModel movie;

  const _DetailsBody({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 2),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              movie.title,
              style: TextStyle(
                fontSize: movie.title.length < 30 ? 40 : 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _StarRating(
                  max: 10,
                  rating: double.tryParse(movie.imdbRating) ?? 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      movie.type.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Text(
                  Resources.of(context).getResource("presentation.home.plot"),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(movie.plot),
                ),
                _TextRow(
                    title: Resources.of(context)
                        .getResource("presentation.home.genre"),
                    value: movie.genre),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _TextRow(
                      title: Resources.of(context)
                          .getResource("presentation.home.writer"),
                      value: movie.writer),
                ),
                _TextRow(
                    title: Resources.of(context)
                        .getResource("presentation.home.actor"),
                    value: movie.actors),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: _InfoWithIcons(
                      language: movie.language,
                      released: movie.released,
                      rated: movie.rated,
                      runtime: movie.runtime),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextRow extends StatelessWidget {
  final String title, value;
  final TextStyle? titleStyle;

  const _TextRow({
    Key? key,
    required this.title,
    required this.value,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: titleStyle ??
              const TextStyle(
                fontWeight: FontWeight.bold,
              ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}

class _StarRating extends StatelessWidget {
  final int max;
  final double size = 28;
  final double rating;

  const _StarRating({
    Key? key,
    required this.max,
    required this.rating,
  }) : super(key: key);

  Widget buildStar(int index) {
    Icon icon;
    if (index >= (rating / 2)) {
      icon = Icon(
        Icons.star_border,
        size: size,
      );
    } else if (index > (rating / 2) - 1 && index < (rating / 2)) {
      icon = Icon(
        Icons.star_half,
        color: Colors.amber,
        size: size,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: Colors.amber,
        size: size,
      );
    }
    return InkResponse(
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => buildStar(index))),
        Text(
            " $rating ${Resources.of(context).getResource("presentation.home.outOf")} $max",
            textDirection: Directionality.of(context) == TextDirection.ltr
                ? TextDirection.ltr
                : TextDirection.rtl,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: size - 10)),
      ],
    );
  }
}

class _InfoWithIcons extends StatelessWidget {
  final String language, released, rated, runtime;

  const _InfoWithIcons({
    Key? key,
    required this.language,
    required this.released,
    required this.rated,
    required this.runtime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool rtl = (Directionality.of(context) == TextDirection.rtl);
    Widget buildIcon(String title, value, IconData icon) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.end),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(icon,
                color: Theme.of(context).colorScheme.secondary, size: 33),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: rtl ? TextAlign.end : TextAlign.start,
              textDirection: TextDirection.ltr,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Divider(),
        buildIcon(
            Resources.of(context).getResource("presentation.home.runtime"),
            runtime,
            Icons.timer_outlined),
        const Divider(),
        buildIcon(Resources.of(context).getResource("presentation.home.rated"),
            rated, Icons.accessibility),
        const Divider(),
        buildIcon(
            Resources.of(context).getResource("presentation.home.released"),
            released,
            Icons.date_range),
        const Divider(),
        buildIcon(
            Resources.of(context).getResource("presentation.home.language"),
            language,
            Icons.language),
      ],
    );
  }
}
