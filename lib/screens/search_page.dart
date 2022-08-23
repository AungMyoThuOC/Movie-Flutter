import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:top_rate_movie/pages/details_page.dart';
import '../models/movie.dart';
import '../network/api.dart';

class GetSearch extends StatefulWidget {
  const GetSearch({Key? key}) : super(key: key);

  @override
  State<GetSearch> createState() => _GetSearchState();
}

class _GetSearchState extends State<GetSearch> {
  TextEditingController searchvalue = TextEditingController();

  String movieName = '';

  List<Movie>? getsearch;
  String? overview;
  String? searchText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: TextFormField(
            controller: searchvalue,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            onFieldSubmitted: (value) {
              searchText = value;
              API().getSearch(value).then((value) {
                setState(() {
                  getsearch = value;
                });
                searchvalue.clear();
                print(getsearch!.length);
              });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.white),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  API().getSearch(searchvalue.text).then((value) {
                    setState(() {
                      getsearch = value;
                    });
                    print(getsearch!.length);
                  });
                },
                color: Colors.white,
              ),
            ),
          )),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getsearch == null
              ? const Center(
                  child: Text(
                    'Search',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Results for "$searchText"',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: getsearch!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return searchDesign(
                                    movienum: index, Movietype: getsearch);
                              })),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class searchDesign extends StatelessWidget {
  int movienum;
  List<Movie>? Movietype;
  searchDesign({Key? key, required this.movienum, required this.Movietype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imglink =
        'https://image.tmdb.org/t/p/w200${Movietype![movienum].posterPath}';
    return Container(
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Movietype == null
              ? const Center(
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: SpinKitCubeGrid(
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: SizedBox(
                      width: 150,
                      child: CachedNetworkImage(
                        imageUrl: imglink,
                        placeholder: (context, url) => const SizedBox(
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SpinKitFadingCube(
                              color: Colors.white,
                              size: 40.0,
                            ),
                          )),
                        ),
                        errorWidget: (context, url, error) => Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 200,
                              child: Icon(
                                Icons.error,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Unavaliable',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 150,
                  child: Text(
                    Movietype![movienum].originalTitle,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: SizedBox(
                  width: 150,
                  child: Text(
                    'Release Date : ${Movietype![movienum].releaseDate}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 150,
                  child: Row(
                    children: [
                      const Text(
                        ' Rated : ',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Text(
                        '${Movietype![movienum].voteAverage}',
                        style: TextStyle(
                            fontSize: 15,
                            color: Movietype![movienum].voteAverage > 7
                                ? const Color.fromARGB(255, 26, 88, 29)
                                : const Color.fromARGB(255, 123, 123, 0),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 150,
                  child: Text(
                    'Overview : ${Movietype![movienum].overview}',
                    maxLines: 3,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 15,
                        child: Icon(Icons.play_arrow),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 15,
                        child: Icon(
                          Icons.thumb_up_alt_outlined,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(90, 255, 255, 255),
                        radius: 15,
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
