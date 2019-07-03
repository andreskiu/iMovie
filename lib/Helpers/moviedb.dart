import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

const _apiKey = "a273fa9e1615b4b96ffd26debc27598e";

// void discover

Future<String> login(String usuario, String password) async {
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/authentication/token/new?api_key=' +
          _apiKey);
  print('hizo el primer request');
  if (response.statusCode == 200) {
    print(
        "haciendo segundo req: " + json.decode(response.body)['request_token']);
    http.Response login = await http.post(
        "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=" +
            _apiKey,
        body: {
          "username": usuario,
          "password": password,
          "request_token": json.decode(response.body)['request_token']
        },
        headers: {
          "api_key": _apiKey
        });
    print('hizo el 2 request');
    if (login.statusCode == 200) {
      print('login OK');
      return json.decode(login.body)['request_token'];
    } else {
      print('2do fails: ' + login.body.toString());
      return 'login fails';
    }
  } else {
    return null;
  }
}

Future<dynamic> getMostPopular() async {
  http.Response response = await http
      .get("https://api.themoviedb.org/3/movie/popular?api_key=" + _apiKey);
  // if (response.statusCode == 200) {
  //   peliculas = json.decode(response.body);
  // } else {
  //   peliculas = List();
  // }
  return json.decode(response.body)['results'];
}

Future<dynamic> getMostRated() async {
  http.Response response = await http
      .get("https://api.themoviedb.org/3/movie/top_rated?api_key=" + _apiKey + "&sort_by=vote_average.asc");
  // if (response.statusCode == 200) {
  //   peliculas = json.decode(response.body);
  // } else {
  //   peliculas = List();
  // }
  return json.decode(response.body)['results'];
}

Future<dynamic> getMovieDetails(String id) async {
  http.Response response = await http
      .get("https://api.themoviedb.org/3/movie/"+id+"?api_key=" + _apiKey + "&sort_by=vote_average.asc");
  // if (response.statusCode == 200) {
  //   peliculas = json.decode(response.body);
  // } else {
  //   peliculas = List();
  // }
  return json.decode(response.body);
}

Future<dynamic> getMovieVideos(String id) async {
  http.Response response = await http
      .get("https://api.themoviedb.org/3/movie/"+id+"/videos?api_key=" + _apiKey + "&sort_by=vote_average.asc");
  // if (response.statusCode == 200) {
  //   peliculas = json.decode(response.body);
  // } else {
  //   peliculas = List();
  // }
  return json.decode(response.body)['results'];
}

Future<dynamic> getMovieReviews(String id) async {
  http.Response response = await http
      .get("https://api.themoviedb.org/3/movie/"+id+"/reviews?api_key=" + _apiKey);
  // if (response.statusCode == 200) {
  //   peliculas = json.decode(response.body);
  // } else {
  //   peliculas = List();
  // }
  return json.decode(response.body)['results'];
}