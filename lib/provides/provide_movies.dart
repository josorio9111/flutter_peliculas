import 'package:ejercicio_api/models/credits.dart';
import 'package:ejercicio_api/models/now_playing.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ejercicio_api/models/populares.dart';

final _key = dotenv.env['CLAVE_API'];
String _language = "es-ES";
int _page = 0;
int _pageTop = 0;
int _pageUp = 0;

class MovieProvider extends ChangeNotifier {
  List<Movie> populares = [];
  List<Movie> nowPlaying = [];
  List<Movie> topRated = [];
  List<Movie> upcoming = [];

  MovieProvider() {
    getNowPlaying();
    getPopurales();
    getTopRated();
    getUpComing();
  }

  getUpComing() async {
    _pageUp++;
    var url = Uri.https('api.themoviedb.org', '3/movie/upcoming',
        {'api_key': _key, 'language': _language, 'page': '$_pageUp'});
    var resp = await http.get(url);
    final upResp = Populares.fromJson(resp.body);
    upcoming = [...upcoming, ...upResp.results];
    notifyListeners();
  }

  getTopRated() async {
    _pageTop++;
    var url = Uri.https('api.themoviedb.org', '3/movie/top_rated',
        {'api_key': _key, 'language': _language, 'page': '$_pageTop'});
    var resp = await http.get(url);
    final topResp = Populares.fromJson(resp.body);
    topRated = [...topRated, ...topResp.results];
    notifyListeners();
  }

  getNowPlaying() async {
    var url = Uri.https('api.themoviedb.org', '3/movie/now_playing',
        {'api_key': _key, 'language': _language, 'page': '1'});
    var resp = await http.get(url);
    nowPlaying = NowPlayingResponse.fromJson(resp.body).results;
    notifyListeners();
  }

  getPopurales() async {
    _page++;
    var url = Uri.https('api.themoviedb.org', '3/movie/popular',
        {'api_key': _key, 'language': _language, 'page': '$_page'});
    var resp = await http.get(url);
    final popularesResp = Populares.fromJson(resp.body);
    populares = [...populares, ...popularesResp.results];
    notifyListeners();
  }

  Future<List<Cast>> getCredits(int idMovie) async {
    var url = Uri.https('api.themoviedb.org', '3/movie/$idMovie/credits',
        {'api_key': _key, 'language': _language});
    var resp = await http.get(url);
    final creditsResponse = CreditsResponse.fromJson(resp.body);
    return creditsResponse.cast;
  }
}
