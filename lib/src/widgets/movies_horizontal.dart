import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie.dart';

class MoviesHorizontal extends StatelessWidget {
  final List<Movie> movies;

  MoviesHorizontal({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        pageSnapping: false,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        children: _horizontalCards(context),
      ),
    );
  }

  List<Widget> _horizontalCards(BuildContext context) {
    return movies.map((item) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage("assets/img/no-image.jpg"),
                image: NetworkImage(item.getPosterImg()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(item.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption)
          ],
        ),
      );
    }).toList();
  }
}
