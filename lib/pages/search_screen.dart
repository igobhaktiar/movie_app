import 'package:flutter/material.dart';
import 'package:goflix/api/api.dart';
import 'package:goflix/models/movie_get.dart';
import 'package:goflix/moviekey.dart';
import 'package:goflix/pages/details_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  List<GetMovie> searchResults = [];

  @override
  void initState() {
    super.initState();
  }

  void handleSearch(String query) {
    if (query.isNotEmpty) {
      // Panggil metode pencarian dan tampilkan hasilnya
      Api().searchMovies(query).then((results) {
        setState(() {
          searchResults = results;
        });
      }).catchError((error) {
        print('Error searching movies: $error');
      });
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.bottomCenter,
              color: Colors.grey.withOpacity(1.0),
              child: Center(
                child: TextField(
                  onChanged: (query) {
                    handleSearch(query);
                  },
                  onSubmitted: (query) {
                    handleSearch(query);
                  },
                  decoration: const InputDecoration(
                      hintText: 'Search Movie...',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.mic_outlined,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  // Ganti widget SearchResultScreen dengan kode di dalamnya
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final getMovie = searchResults[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                getMovie: getMovie,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.1),
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    height: 100,
                                    width: 200,
                                    child: Image.network(
                                      '${MovieKey.gambarDir}${getMovie.posterMovie}',
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          getMovie.judulMovie,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
