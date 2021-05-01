import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_list.dart';
import 'package:movieapp/screens/movie_details.dart';
import 'package:movieapp/services/services.dart';

class MovieCategories extends StatefulWidget {
  final String genre;

  const MovieCategories({Key key, this.genre}) : super(key: key);

  @override
  _MovieCategoriesState createState() => _MovieCategoriesState();
}

class _MovieCategoriesState extends State<MovieCategories> {
  Services services = Services();
  Future<Welcome> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = services.fetchAlbum(widget.genre);
    //futureAlbum = services.fetchAlbum(genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            // widget.genre,
            widget.genre.toUpperCase(),
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.save_alt,
                  color: Colors.grey,
                ),
                onPressed: () {})
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.1), //(x,y)
                        blurRadius: 4.0,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/spiderman_0.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.52,
                child: SafeArea(
                  child: Column(children: [
                    FutureBuilder<Welcome>(
                      future: futureAlbum,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Movie> content =
                              snapshot.data.data.movies.toList();

                          return Container(
                            height: MediaQuery.of(context).size.height * 0.52,
                            width: double.infinity,
                            child: ListView.separated(
                              itemBuilder: (BuildContext context, int index) {
                                return
//                      Shimmer.fromColors(
//                      baseColor: Colors.grey[400],
//                      highlightColor: Colors.white,
//                      direction: ShimmerDirection.ltr,
//                      period: Duration(seconds: 3),
                                    Container(
                                  height: 155,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MovieDetails(
                                                            id: snapshot
                                                                .data
                                                                .data
                                                                .movies[index]
                                                                .id)));
                                          },
                                          child: Container(
                                            height: 130,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  snapshot
                                                              .data
                                                              .data
                                                              .movies[index]
                                                              .mediumCoverImage !=
                                                          null
                                                      ? snapshot
                                                          .data
                                                          .data
                                                          .movies[index]
                                                          .mediumCoverImage
                                                      : 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Column(
//                                    mainAxisAlignment:
//                                        MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child: Text(
                                                        content[index].title,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 21,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.red,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot.data.data
                                                      .movies[index].year
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  content[index]
                                                      .genres
                                                      .toString()
                                                      .replaceAll('[', "")
                                                      .replaceAll(']', ''),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.red,
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: Text(
                                                        'IMDb: ${snapshot.data.data.movies[index].rating.toString()}',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                //Accessing nested listView elements
                                                Row(
                                                  children: [
                                                    for (var t in snapshot
                                                        .data
                                                        .data
                                                        .movies[index]
                                                        .torrents)
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.save_alt,
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                            Text(t.quality),
                                                            // Text(snapshot.data.data.movies[index].torrents[index].quality)
                                                            //shows error: invalid value-not in range 0..1.2 because only 0,1 index are
                                                            //available in torrent.quality
                                                          ],
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      width: 5,
                                                    )
                                                  ],
                                                ),

//                                                Or,
                                                //Accessing nested listView elements
//                                                Container(
//                                                  height: 50,
//                                                  child: ListView.builder(
//                                                    itemCount: snapshot
//                                                        .data
//                                                        .data
//                                                        .movies[index]
//                                                        .torrents
//                                                        .length,
//                                                    itemBuilder:
//                                                        (context, index) => Row(
//                                                      children: [
//
//                                                        Container(
//                                                          child: Row(
//                                                            children: [
//                                                              Icon(
//                                                                Icons.save_alt,
//                                                                color: Colors
//                                                                    .green,
//                                                              ),
//                                                              // Text(t.quality),
//                                                              Text(snapshot
//                                                                  .data
//                                                                  .data
//                                                                  .movies[index]
//                                                                  .torrents[
//                                                              index]
//                                                                  .quality
//                                                                  .toString())
//                                                            ],
//                                                          ),
//                                                        ),
//                                                        SizedBox(
//                                                          width: 5,
//                                                        )
//                                                      ],
//                                                    ),
//                                                  ),
//                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // ),
                                );
                              },
                              itemCount: snapshot.data.data.movies.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Divider(
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    )
                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}
