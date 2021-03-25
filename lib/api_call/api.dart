import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  
  List<String> room= [];
  



  Future<http.Response> callRecommendation() async {
    final response = await http.post(
     "https://6f13b6cc5bc9.ngrok.io/rent/recomendations/call/json/get_recommendations",
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },

    body: jsonEncode(<String, Map<String, Map<String, Object>>>{
       
          "watched_movies": {
            "1307": {
              "movieId": 1307,
              "title": "Dirty Dancing (1987)",
              "genres": "Comedy|Romance",
              "poster": "True",
              "rating": 5
            }
          }
        
      }),
    );
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("${response.statusCode}");
      print("bhayo");
      return null;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
