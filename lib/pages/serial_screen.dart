import 'package:flutter/material.dart';
import 'package:goflix/api/api.dart';
import 'package:goflix/models/serial_get.dart';
import 'package:goflix/widgets/list_serial.dart';
import 'package:goflix/widgets/search_widget.dart';
import 'package:goflix/widgets/serial_trending.dart';
import 'package:google_fonts/google_fonts.dart';

class SerialScreen extends StatefulWidget {
  const SerialScreen({super.key});

  @override
  State<SerialScreen> createState() => _SerialScreen();
}

class _SerialScreen extends State<SerialScreen> {
  late Future<List<GetSerial>> trendSeries;
  late Future<List<GetSerial>> topSerial;
  late Future<List<GetSerial>> popularSerial;

  @override
  void initState() {
    super.initState();
    trendSeries = Api().trendingSerial();
    topSerial = Api().topRatedSeries();
    popularSerial = Api().popularSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: searchWidget(context),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Trending Series',
                style: GoogleFonts.poppins(fontSize: 24),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              child: FutureBuilder(
                future: trendSeries,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return TrendSerial(
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
                  future: topSerial,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return ListSerial(
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
                  future: popularSerial,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return ListSerial(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ]),
        ));
  }
}
