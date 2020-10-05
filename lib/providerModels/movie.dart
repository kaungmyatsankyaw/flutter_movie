import 'package:flutter/foundation.dart';

class Movie extends ChangeNotifier {
  Map movie = {"loading":false,"movie":""};

  setMovie(var movie) {
    movie["loading"] = true;
    movie["movie"] = movie;
    notifyListeners();
  }

   getMovie() => movie;
}
