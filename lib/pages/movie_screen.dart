import 'package:flutter/material.dart';
import 'package:goflix/api/api.dart';
import 'package:goflix/models/movie_get.dart';
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
  late Future<List<GetMovie>> showMovies;
  late Future<List<GetMovie>> topMovies;
  late Future<List<GetMovie>> comingMovies;

  @override
  void initState() {
    super.initState();
    showMovies = Api().trendingMovies();
    topMovies = Api().topRatedMovies();
    comingMovies = Api().upcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: searchWidget(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Trending Movies',
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
                  'Top Rated',
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
            ],
          ),
        ));
  }
}
