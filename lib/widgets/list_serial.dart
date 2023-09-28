import 'package:flutter/material.dart';
import 'package:goflix/moviekey.dart';
import 'package:goflix/pages/detail_series.dart';

class ListSerial extends StatelessWidget {
  const ListSerial({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final getMovie = snapshot.data![index];
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailSeries(
                        getSeries: snapshot.data[index],
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 150,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 200,
                          width: 150,
                          child: Image.network(
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              '${MovieKey.gambarDir}${snapshot.data![index].posterMovie}'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        getMovie.judulMovie,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
