import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_details.dart';
import 'package:movieapp/screens/movie_suggestion.dart';
import 'package:movieapp/services/services.dart';
import 'package:movieapp/widgets/circular_clipper.dart';

class MovieDetails extends StatefulWidget {
  final int id;

  const MovieDetails({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Services services = Services();
  Future<MovieDetail> futureDetails;

  @override
  void initState() {
    super.initState();
    futureDetails = services.futureDetails(widget.id);
    //futureAlbum = services.fetchAlbum(genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<MovieDetail>(
          future: futureDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.data.movie.id);
              print(snapshot.data.data.movie.id.toString());
//              print(snapshot.data.data.movie.cast);
              List<Cast> casts = snapshot.data.data.movie.cast.toList();

              List<String> genre = snapshot.data.data.movie.genres;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                          child: ClipShadowPath(
                            clipper: CircularClipper(),
                            shadow: Shadow(blurRadius: 20.0),
                            child: Image(
                              height: 400.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  snapshot.data.data.movie.mediumCoverImage),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              padding: EdgeInsets.only(left: 30.0),
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back),
                              iconSize: 30.0,
                              color: Colors.black,
                            ),
                            Image(
                              image:
                                  AssetImage('assets/images/netflix_logo.png'),
                              height: 60.0,
                              width: 150.0,
                            ),
                            IconButton(
                              padding: EdgeInsets.only(left: 30.0),
                              onPressed: () => print('Add to Favorites'),
                              icon: Icon(Icons.favorite_border),
                              iconSize: 30.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        Positioned.fill(
                          bottom: 10.0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: RawMaterialButton(
                              padding: EdgeInsets.all(10.0),
                              elevation: 12.0,
                              onPressed: () => print('Play Video'),
                              shape: CircleBorder(),
                              fillColor: Colors.white,
                              child: Icon(
                                Icons.play_arrow,
                                size: 60.0,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 20.0,
                          child: IconButton(
                            onPressed: () => print('Add to My List'),
                            icon: Icon(Icons.add),
                            iconSize: 40.0,
                            color: Colors.black,
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 25.0,
                          child: IconButton(
                            onPressed: () => print('Share'),
                            icon: Icon(Icons.share),
                            iconSize: 35.0,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            snapshot.data.data.movie.title.toUpperCase(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.0),
                          SizedBox(
                            height: 20,
                            child: Center(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: genre.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    genre[index].toString() == null
                                        ? ''
                                        : genre[index].toString(),
//                                      .replaceAll('[', "")
//                                      .replaceAll(']', ''),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 12.0),
                          //for (var t in genre) Text(genre.toString()),
                          Text(
                            '⭐ ⭐ ⭐ ⭐',
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.orange),
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Year',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 2.0),
                                  Text(
                                    snapshot.data.data.movie.year.toString(),
//                                        ==
//                                            null
//                                        ? ''
//                                        : snapshot.data.data.movie.year
//                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Country',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 2.0),
                                  Text(
                                    snapshot.data.data.movie.language == null
                                        ? ''
                                        : snapshot.data.data.movie.language
                                            .toUpperCase(), //country
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Length',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 2.0),
                                  Text(
                                    '${snapshot.data.data.movie.runtime} min',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 25.0),
                          Row(
                            children: [
                              Text(
                                'Casts',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Container(
                            height: 120,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: casts.length,
                                itemBuilder: (context, int index) {
//                                  return Text(
//                                    '${snapshot.data.data.movie.cast[index].name} ,\t',
//                                    style: TextStyle(
//                                        fontWeight: FontWeight.bold,
//                                        fontSize: 16.0),
//                                  );
                                  return Row(
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              casts[index].urlSmallImage != null
                                                  ? casts[index].urlSmallImage
                                                  : 'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Text(
                                            casts[index].name == null
                                                ? ''
                                                : casts[index].name,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent),
                                          ),
                                          Text(
                                            casts[index].characterName == null
                                                ? ''
                                                : casts[index].characterName,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
//                          height: 120.0,
//                          child: ExpandablePanel(
//                            header: Text(
//                              'Description',
//                              style: TextStyle(fontWeight: FontWeight.w500),
//                            ),
//                            expanded: Text(
//                              snapshot.data.data.movie.descriptionIntro,
//                              style: TextStyle(
//                                color: Colors.black54,
//                              ),
//                              softWrap: true,
//                            ),
//                          ),
                            child: Text(
                              snapshot.data.data.movie.descriptionIntro == null
                                  ? ''
                                  : snapshot.data.data.movie.descriptionIntro,
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SuggestionMovie(id: snapshot.data.data.movie.id),
//            images: widget.movie.screenshots,
//            title: 'Screenshots',
//            imageHeight: 200.0,
//            imageWidth: 250.0,
//          ),
                  ],
                ),
              );
            }
//            else if(snapshot.data.data.movie.cast.length==0){
//              Center(child: CircularProgressIndicator(),);
            //  }
            else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
