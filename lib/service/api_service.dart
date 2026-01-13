import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    final List data = jsonDecode(res.body);

    return data.map((e) => Product.fromJson(e)).toList();
  }
}
