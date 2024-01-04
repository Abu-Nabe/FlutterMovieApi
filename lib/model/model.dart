// Object to store movie data
class MovieModel {
  String title;
  int year;
  String type;
  String poster;

  MovieModel(this.title, this.year, this.type, this.poster);

  MovieModel.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        year = map['year'],
        type = map['type'],
        poster = map['poster'];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'year': year,
      'type': type,
      'poster': poster,
    };
  }
}
