import 'package:flutter/material.dart';
import 'package:ejercicio_api/models/populares.dart';

class ListaSlider extends StatefulWidget {
  const ListaSlider(
      {super.key, required this.movies, this.title, required this.nextPage});
  final List<Movie> movies;
  final String? title;
  final Function nextPage;

  @override
  State<ListaSlider> createState() => _ListaSliderState();
}

class _ListaSliderState extends State<ListaSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_listener);
    super.initState();
  }

  _listener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 500) {
      widget.nextPage();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (widget.movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 275,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.title!,
              style: const TextStyle(fontSize: 22),
            ),
          ),
        const SizedBox(height: 5),
        Expanded(
            child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: widget.movies.length,
          itemBuilder: (_, index) => _CardWidget(
              movie: widget.movies[index],
              heroId: '${widget.title}-$index-${widget.movies[index].id}'),
        ))
      ]),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({required this.movie, required this.heroId});
  final Movie movie;
  final String heroId;

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.png'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
