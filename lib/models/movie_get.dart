class GetMovie {
  String judulMovie;
  String gambarMovie;
  String judulOri;
  String deskripsi;
  String posterMovie;
  String tglRilis;
  double rataVote;

  GetMovie({
    required this.judulMovie,
    required this.gambarMovie,
    required this.judulOri,
    required this.deskripsi,
    required this.posterMovie,
    required this.tglRilis,
    required this.rataVote,
  });
  factory GetMovie.fromJson(Map<String, dynamic> json) {
    return GetMovie(
      judulMovie: json["title"],
      gambarMovie: json["backdrop_path"],
      judulOri: json["original_title"],
      deskripsi: json["overview"],
      posterMovie: json["poster_path"],
      tglRilis: json["release_date"],
      rataVote: json["vote_average"].toDouble(),
    );
  }
}
