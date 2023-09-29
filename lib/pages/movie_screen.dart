import 'package:flutter/material.dart';
import 'package:goflix/api/api.dart';
import 'package:goflix/models/movie_get.dart';
import 'package:goflix/models/serial_get.dart';
import 'package:goflix/pages/serial_screen.dart';
import 'package:goflix/widgets/list_movie.dart';
import 'package:goflix/widgets/search_widget.dart';
import 'package:goflix/widgets/slider_trending.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreen();
}

class _MovieScreen extends State<MovieScreen> {
  late Future<List<GetSerial>> trendSeries;
  late Future<List<GetMovie>> showMovies;
  late Future<List<GetMovie>> topMovies;
  late Future<List<GetMovie>> comingMovies;

  List<GetMovie> searchResults = [];

  @override
  void initState() {
    super.initState();
    trendSeries = Api().trendingSerial();
    showMovies = Api().trendingMovies();
    topMovies = Api().topRatedMovies();
    comingMovies = Api().upcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchWidget(context),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 450) {
            return mobileView();
          } else {
            return webView();
          }
        },
      ),
    );
  }

  SingleChildScrollView mobileView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Trending Now !',
              style: GoogleFonts.poppins(fontSize: 24),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            child: FutureBuilder(
              future: showMovies,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return TrendingSlider(
                    snapshot: snapshot,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Top Rated Movie',
              style: GoogleFonts.poppins(fontSize: 24),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SizedBox(
              child: FutureBuilder(
                future: topMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return ListMovie(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Upcoming',
              style: GoogleFonts.poppins(fontSize: 24),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SizedBox(
              child: FutureBuilder(
                future: comingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return ListMovie(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          if (searchResults.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Search Results',
                    style: GoogleFonts.poppins(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 16),
                // Ganti tipe data snapshot dengan AsyncSnapshot<List<GetMovie>>
                FutureBuilder<List<GetMovie>>(
                  future: Future.value(
                      searchResults), // Gunakan Future.value untuk membuat Future<List<GetMovie>>
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return ListMovie(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }

  SingleChildScrollView webView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                OutlinedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 20.0,
                      ),
                    ),
                  ),
                  child: const Text('Movie'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MovieScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 20.0,
                      ),
                    ),
                  ),
                  child: const Text('Serial TV'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SerialScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Trending Now !',
              style: GoogleFonts.poppins(fontSize: 24),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            child: FutureBuilder(
              future: showMovies,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return ListMovie(
                    snapshot: snapshot,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Top Rated Movie',
              style: GoogleFonts.poppins(fontSize: 24),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SizedBox(
              child: FutureBuilder(
                future: topMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return ListMovie(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Upcoming',
              style: GoogleFonts.poppins(fontSize: 24),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: SizedBox(
              child: FutureBuilder(
                future: comingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return ListMovie(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          if (searchResults.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Search Results',
                    style: GoogleFonts.poppins(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 16),
                // Ganti tipe data snapshot dengan AsyncSnapshot<List<GetMovie>>
                FutureBuilder<List<GetMovie>>(
                  future: Future.value(
                      searchResults), // Gunakan Future.value untuk membuat Future<List<GetMovie>>
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return ListMovie(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
