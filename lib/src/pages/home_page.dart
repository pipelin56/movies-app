import 'package:flutter/material.dart';
import 'package:movies_app/src/providers/movie_provider.dart';
import 'package:movies_app/src/widgets/card_swiper.dart';
import 'package:movies_app/src/widgets/movies_horizontal.dart';

class HomePage extends StatelessWidget {
  final movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Current movies"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_cardSwipper(), _cardFooter(context)],
      )),
    );
  }

  Widget _cardSwipper() {
    return FutureBuilder(
      future: movieProvider.getOnCinemas(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _cardFooter(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text("Popular",
                    style: Theme.of(context).textTheme.subtitle1)),
            SizedBox(
              height: 5.0,
            ),
            FutureBuilder(
              future: movieProvider.getPopular(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return MoviesHorizontal(movies: snapshot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ));
  }
}
