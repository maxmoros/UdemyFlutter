import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    final url = 'https://fluttertest-7ac61.firebaseio.com/products/${this.id}.json';
    final response = await http.patch(url,
        body: json.encode(
          {'isFavorite': !this.isFavorite},
        ));
    if (response.statusCode >= 400) {
      print('Error pushing favorite :(');
      throw HttpException('You dropped a banana');
    } else {
      isFavorite = !isFavorite;
      notifyListeners();
    }
  }
}
