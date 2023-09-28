class GetSerial {
  String judulMovie;
  String gambarMovie;
  String judulOri;
  String deskripsi;
  String posterMovie;
  String tglRilis;
  double rataVote;

  GetSerial({
    required this.judulMovie,
    required this.gambarMovie,
    required this.judulOri,
    required this.deskripsi,
    required this.posterMovie,
    required this.tglRilis,
    required this.rataVote,
  });
  factory GetSerial.fromJson(Map<String, dynamic> json) {
    return GetSerial(
      judulMovie: json["name"],
      gambarMovie: json["backdrop_path"],
      judulOri: json["original_name"],
      deskripsi: json["overview"],
      posterMovie: json["poster_path"],
      tglRilis: json["first_air_date"],
      rataVote: json["vote_average"].toDouble(),
    );
  }
}
