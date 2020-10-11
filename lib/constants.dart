import 'package:flutter/material.dart';

const apiKey = "5c2883f21395dafeda821ef486db0dea";
const baseUrl = "https://api.themoviedb.org/3/";
const popuarlMovie = "movie/popular";
const nowPlaying = "movie/now_playing";
const upComingMovie = "movie/upcoming";
const tvList = "tv/popular";
const movieDetail = "movie/";

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
