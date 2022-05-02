import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Rating> fetchRating(String platformId, String platformUserId) async {
  final response = await http.get(Uri.parse(
      'https://rating12389.herokuapp.com/api/' +
          platformId.toLowerCase() +
          '/' +
          platformUserId));

  if (response.statusCode == 200) {
    return Rating.fromJson(jsonDecode(response.body));
  } else {
    throw Exception();
  }
}

Future<dynamic> showRating(
    String platformId, String platformUserId, BuildContext context) async {
  var rating = await fetchRating(platformId, platformUserId);
  String userRating = rating.rating;
  print("Your rating at " + platformId + " is " + userRating);
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Your rating at " + platformId + " is " + userRating),
        );
      });
}

class Rating {
  final String rating;

  const Rating({
    required this.rating,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rating: json['rating'],
    );
  }
}
