import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goflix/moviekey.dart';
import 'package:goflix/pages/detail_series.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendSerial2 extends StatelessWidget {
  const TrendSerial2({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: snapshot.data.length,
          options: CarouselOptions(
              height: 150,
              autoPlay: true,
              viewportFraction: 0.55,
              // enlargeCenterPage: true,
              // pageSnapping: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(seconds: 1)),
          itemBuilder: (context, itemIndex, pageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailSeries(
                      getSeries: snapshot.data[itemIndex],
                    ),
                  ),
                );
              },
              child: SizedBox(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        height: 150,
                        width: 200,
                        child: Image.network(
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fitWidth,
                            '${MovieKey.gambarDir}${snapshot.data[itemIndex].posterMovie}'),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: Container(
                          color: Colors.black.withOpacity(0.7),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.data[itemIndex].judulMovie,
                              style: GoogleFonts.poppins(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
