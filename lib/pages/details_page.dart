// import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:top_rate_movie/models/cast.dart';
import 'package:top_rate_movie/models/movie.dart';
import 'package:top_rate_movie/network/api.dart';
import 'package:top_rate_movie/pages/blur_background.dart';
import 'package:top_rate_movie/screens/search_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailPage extends StatefulWidget {
  Movie movie;
  DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var api = API();
  List<Cast>? casts;

  @override
  void initState() {
    // super.initState();
    api.getCast(widget.movie.id).then((value) {
      setState(() {
        casts = value;
      });
    });
  }

  // _castInformation() => ListView.builder(
  //   scrollDirection: Axis.vertical,
  //   itemCount: casts!.length,
  //   shrinkWrap: true,
  //   physics: BouncingScrollPhysics(),
  //   itemBuilder: (BuildContext contex, int index) {
  //     Cast c = casts![index];
  //     return Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Row(
  //         children: [
  //           CircleAvatar(
  //             backgroundImage: CachedNetworkImageProvider(
  //                API.imageURL + c.profilePath,
  //             )
  //           ),
  //           const SizedBox(
  //             width: 12,
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //             c.originalName,
  //             style: const TextStyle(
  //               color: Colors.white
  //             ),
  //             ),
  //             Text(
  //             c.character,
  //             style: const TextStyle(
  //               color: Colors.white24
  //             ),
  //             ),
  //             ],
  //           )
  //         ],
  //       ),
  //     );
  //   },
  // );
  _movieInformation() => Column(
        children: [
          Image(
            image: CachedNetworkImageProvider(
                API.imageURL + widget.movie.backdropPath),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.movie.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.movie.overview,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.movie.title),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border))
          ],
          // leading: IconButton(
          //   onPressed: (){},
          //   icon: Icon(
          //     Icons.bookmark
          //   )
          // ),
        ),
        body: Stack(
          children: [
            BlurBackground(
              backdropPath: widget.movie.backdropPath,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _movieInformation(),
                  const SizedBox(
                    height: 12,
                  ),
                  // casts == null
                  // ? const CircularProgressIndicator()
                  // : _castInformation()
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Icon(
                        Icons.check,
                        color: Colors.white,
                        // FontAwesomeIcons.check,
                        size: 30.0,
                      ),
                      const Icon(
                        Icons.share,
                        color: Colors.white,
                        // FontAwesomeIcons.shareAlt,
                        size: 30.0,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      const Text(
                        'My List',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Text(
                        'Share',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(
                  //     top: 8.0, bottom: 8.0
                  //   ),
                  // ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${widget.movie.voteAverage}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${widget.movie.releaseDate}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // Text(
                  //   'Cast',
                  //   style: TextStyle(
                  //     fontSize: 18.0,
                  //     color: Colors.white
                  //   ),
                  // ),
                  // Actors(movieId),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // Text(
                  //   'Similar Movies',
                  //   style: TextStyle(
                  //     fontSize: 18.0
                  //   ),
                  // ),
                  // SimilarMovies(movieId),
                ],
              ),
            )
          ],
        ));
  }
}
