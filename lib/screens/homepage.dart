import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_list.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/movie_screen.dart';
import 'package:movieapp/screens/movie_category.dart';
import 'package:movieapp/screens/my_list.dart';
import 'package:movieapp/screens/my_popular.dart';
import 'package:movieapp/services/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  Services services = Services();
  // Future<Welcome> futureAlbum;
  @override
  void initState() {
    super.initState();
    // futureAlbum = services.fetchMovie();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  _movieSelector(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieScreen(movie: movies[index]),
          ),
        ),
//        onTap: () {},
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                    tag: movies[index].imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: AssetImage(movies[index].imageUrl),
                        height: 220.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30.0,
              bottom: 40.0,
              child: Container(
                width: 250.0,
                child: Text(
                  movies[index].title.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image(
          image: AssetImage('assets/images/netflix_logo.png'),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(left: 30.0),
          onPressed: () => print('Menu'),
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 30.0),
            onPressed: () => print('Search'),
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.black,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 280.0,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                return _movieSelector(index);
              },
            ),
          ),
          Container(
            height: 90.0,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieCategories(
                                      genre: 'action',
                                    )));
                        break;
                      case 1:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieCategories(
                                      genre: 'adventure',
                                    )));
                        break;
                      case 2:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieCategories(
                                      genre: 'biography',
                                    )));
                        break;
                      case 3:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieCategories(
                                      genre: 'comedy',
                                    )));
                        break;
                      case 4:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieCategories(
                                      genre: 'drama',
                                    )));
                        break;
                      case 5:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieCategories(
                                      genre: 'family',
                                    )));
                        break;
                      case 6:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieCategories(
                                      genre: 'romance',
                                    )));
                        break;
                      case 7:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieCategories(
                                      genre: 'sci-fi',
                                    )));
                        break;
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    width: 160.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFD45253),
                          Color(0xFF9E1F28),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF9E1F28),
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        category[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.8,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          MyList(),
          SizedBox(height: 10.0),
          MyPopular(),
//          MyList(
//            images: popular,
//            title: 'Popular',
//            imageHeight: 250.0,
//            imageWidth: 150.0,
//          ),
        ],
      ),
    );
  }
}

final List<String> category = [
  'Action',
  'Adventure',
  'Biography',
  'Comedy',
  'Drama',
  'Family',
  'Romance',
  'Sci-Fi'
];
