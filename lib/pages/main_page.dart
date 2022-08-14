// import 'dart:ffi';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:top_rate_movie/pages/details_page.dart';
import '../models/movie.dart';
import '../network/api.dart';

class MoviePage extends StatefulWidget {
  MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<Movie>? topRatedMovies = [];
  List<Movie>? upcomingMovies = [];
  List<Movie>? nowPlayingMovies = [];

  getTopRatedList() {
    API().getTopRated("top_rated").then((value) {
      setState(() {
        topRatedMovies = value;
        print(topRatedMovies!.length);
      });
    });
  }

  getUpcomingList() {
    API().getUpcoming("upcoming").then((value) {
      setState(() {
        upcomingMovies = value;
        print(upcomingMovies!.length);
      });
    });
  }

  getNowPlayingList() {
    API().getNowPlaying("now_playing").then((value) {
      setState(() {
        nowPlayingMovies = value;
        print(nowPlayingMovies!.length);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTopRatedList();
    getUpcomingList();
    getNowPlayingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: topRatedMovies == null
            ? const Center(child: CircularProgressIndicator())
            : Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const Text("TopRated"),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: topRatedMovies!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Movie m = topRatedMovies![index];
                            return InkWell(
                              onTap: (){
                                 Navigator.push(context,
                                   MaterialPageRoute(
                                    builder: 
                                    (context) => DetailPage(movie: m,)
                                  )
                                );
                              },
                              child: SizedBox(
                                width: 125,
                                height: 217,
                                child: Card(
                                  child: Column(children: [
                                    SizedBox(
                                      height: 180,
                                      child: Image(
                                        image: CachedNetworkImageProvider(
                                           API.imageURL + m.posterPath
                                        ),
                                      )
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(m.title)
                                  ]),
                                ),
                              ),
                            );
                          }
                        ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Upcoming"),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: upcomingMovies!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Movie m = upcomingMovies![index];
                            return InkWell(
                              onTap: (){
                                 Navigator.push(context,
                                   MaterialPageRoute(
                                    builder: 
                                    (context) => DetailPage(movie: m,)
                                  )
                                );
                              },
                              child: SizedBox(
                                width: 125,
                                height: 217,
                                child: Card(
                                  child: Column(children: [
                                    SizedBox(
                                      height: 180,
                                      child: Image(
                                        image: CachedNetworkImageProvider(
                                          API.imageURL + m.posterPath)),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(m.title)
                                  ]),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text("NowPlaying"),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 230,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: nowPlayingMovies!.length,
                          itemBuilder: (BuildContext context, int index) {
                            Movie m = nowPlayingMovies![index];
                            return InkWell(
                              onTap: (){
                                 Navigator.push(context,
                                   MaterialPageRoute(
                                    builder: 
                                    (context) => DetailPage(movie: m,)
                                  )
                                );
                              },
                              child: SizedBox(
                                width: 125,
                                height: 217,
                                child: Card(
                                  child: Column(children: [
                                    SizedBox(
                                      height: 180,
                                      child: Image(
                                        image: CachedNetworkImageProvider(
                                          API.imageURL + m.posterPath)),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(m.title)
                                  ]),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
