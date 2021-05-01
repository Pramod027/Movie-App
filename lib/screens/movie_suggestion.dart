import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_list.dart';
import 'package:movieapp/models/movie_suggestion.dart';
import 'package:movieapp/screens/movie_details.dart';
import 'package:movieapp/services/services.dart';

class SuggestionMovie extends StatefulWidget {
  final int id;

  const SuggestionMovie({Key key, this.id}) : super(key: key);
  @override
  _SuggestionMovieState createState() => _SuggestionMovieState();
}

class _SuggestionMovieState extends State<SuggestionMovie> {
  Services services = Services();
  Future<MovieSuggestions> suggestMovies;
  String genre = 'action';

  @override
  void initState() {
    super.initState();
    suggestMovies = services.suggestionDetails(widget.id);
    //futureAlbum = services.fetchAlbum(genre);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Suggestion Movies',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 250.0,
          child: FutureBuilder<MovieSuggestions>(
            future: suggestMovies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.movies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetails(
                                        id: snapshot
                                            .data.data.movies[index].id)));
                          },
                          child: Image(
                            image: NetworkImage(snapshot
                                .data.data.movies[index].mediumCoverImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
