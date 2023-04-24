import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ejercicio_api/provides/provide_movies.dart';
import 'package:ejercicio_api/models/credits.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({super.key, required this.idMovie});
  final int idMovie;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    return FutureBuilder(
      future: provider.getCredits(idMovie),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Cast> listaCast = snapshot.data!;
          return Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 275,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Casting',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listaCast.length,
                itemBuilder: (_, index) => _CardWidget(
                  cast: listaCast[index],
                ),
              ))
            ]),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({required this.cast});
  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.png'),
              image: NetworkImage(cast.fullProfilePath),
              width: 130,
              height: 190,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            cast.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
