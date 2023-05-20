import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:movies_app/app/localization/resources.dart';
import 'package:movies_app/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/movie_details_model.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(100),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          DropdownButton<String>(
            underline: const SizedBox(),
            icon: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
            onChanged: (String? val) {
              if (val == "preview") {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => Dialog(
                    child: Image.network(
                      Provider.of<HomeViewModel>(context, listen: false)
                          .movieDetails
                          .poster,
                    ),
                  ),
                );
              }
            },
            dropdownColor:
                Theme.of(context).colorScheme.background.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            items: const [
              DropdownMenuItem(
                child: Text("Preview Poster"),
                value: "preview",
              )
            ],
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(builder: (context, model, _) {
        return model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Animate(effects: [
                    FadeEffect(
                      duration: 1.seconds,
                      begin: 0,
                    ),
                  ], child: _BackgroundImage(url: model.movieDetails.poster)),
                  Animate(effects: [
                    SlideEffect(
                      begin: const Offset(0, 0.2),
                      delay: Duration.zero,
                      duration: 0.5.seconds,
                    ),
                  ], child: _DetailsBody(movie: model.movieDetails)),
                ],
              );
      }),
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
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  final MovieDetailsModel movie;

  const _DetailsBody({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            movie.title,
            maxLines: 3,
            style: TextStyle(
              fontSize: movie.title.length < 30 ? 35 : 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 20,
              ),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                _StarRating(
                  max: 10,
                  rating: double.tryParse(movie.imdbRating) ?? 0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    Resources.of(context).getResource("presentation.home.plot"),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(movie.plot),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _TextRow(
                      title: Resources.of(context)
                          .getResource("presentation.home.type"),
                      value: movie.type),
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
        ),
      ],
    );
  }
}

class _TextRow extends StatelessWidget {
  final String title, value;

  const _TextRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
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
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: rtl ? TextAlign.end : TextAlign.start,
              textDirection: TextDirection.ltr,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(icon,
                color: Theme.of(context).colorScheme.secondary, size: 33),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
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
