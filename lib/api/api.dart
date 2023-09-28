import 'dart:convert';
import 'package:goflix/models/movie_get.dart';
import 'package:goflix/models/serial_get.dart';
import 'package:goflix/moviekey.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _trendingMovie =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${MovieKey.keyApi}';
  static const _topRatedMovie =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${MovieKey.keyApi}';
  static const _upcomingMovie =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${MovieKey.keyApi}';
  static const _trendingSerial =
      'https://api.themoviedb.org/3/trending/tv/week?api_key=${MovieKey.keyApi}';
  static const _popularSerial =
      'https://api.themoviedb.org/3/tv/popular?api_key=${MovieKey.keyApi}';
  static const _topRatedSerial =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=${MovieKey.keyApi}';

  Future<List<GetMovie>> trendingMovies() async {
    final getMovie = await http.get(Uri.parse(_trendingMovie));
    if (getMovie.statusCode == 200) {
      final movieData = json.decode(getMovie.body)['results'] as List;
      return movieData.map((movie) => GetMovie.fromJson(movie)).toList();
    } else {
      throw Exception('Gagal terhubung!');
    }
  }

  Future<List<GetMovie>> topRatedMovies() async {
    final getMovie = await http.get(Uri.parse(_topRatedMovie));
    if (getMovie.statusCode == 200) {
      final movieData = json.decode(getMovie.body)['results'] as List;
      return movieData.map((movie) => GetMovie.fromJson(movie)).toList();
    } else {
      throw Exception('Gagal terhubung!');
    }
  }

  Future<List<GetMovie>> upcomingMovies() async {
    final getMovie = await http.get(Uri.parse(_upcomingMovie));
    if (getMovie.statusCode == 200) {
      final movieData = json.decode(getMovie.body)['results'] as List;
      return movieData.map((movie) => GetMovie.fromJson(movie)).toList();
    } else {
      throw Exception('Gagal terhubung!');
    }
  }

  Future<List<GetSerial>> trendingSerial() async {
    final getMovie = await http.get(Uri.parse(_trendingSerial));
    if (getMovie.statusCode == 200) {
      final movieData = json.decode(getMovie.body)['results'] as List;
      return movieData.map((movie) => GetSerial.fromJson(movie)).toList();
    } else {
      throw Exception('Gagal terhubung!');
    }
  }

  Future<List<GetSerial>> popularSeries() async {
    final getMovie = await http.get(Uri.parse(_popularSerial));
    if (getMovie.statusCode == 200) {
      final movieData = json.decode(getMovie.body)['results'] as List;
      return movieData.map((movie) => GetSerial.fromJson(movie)).toList();
    } else {
      throw Exception('Gagal terhubung!');
    }
  }

  Future<List<GetSerial>> topRatedSeries() async {
    final getMovie = await http.get(Uri.parse(_topRatedSerial));
    if (getMovie.statusCode == 200) {
      final movieData = json.decode(getMovie.body)['results'] as List;
      return movieData.map((movie) => GetSerial.fromJson(movie)).toList();
    } else {
      throw Exception('Gagal terhubung!');
    }
  }

  Future<List<GetMovie>> searchMovies(String query) async {
    final url =
        'https://api.themoviedb.org/3/search/movie?api_key=${MovieKey.keyApi}&query=$query';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final movieData = json.decode(response.body)['results'] as List;
      return movieData.map((movie) => GetMovie.fromJson(movie)).toList();
    } else {
      throw Exception('Gagal terhubung ke API TMDb');
    }
  }
}
