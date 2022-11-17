import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:uno/uno.dart';

import 'product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
}

class HttpRepository implements ProductRepository {
  final http = Client();

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await http.get(Uri.http("localhost:3031", "/products"));
      final List decoded = jsonDecode(result.body);
      final products = decoded.map((e) => ProductModel.fromMap(e)).toList();
      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}

class DioRepository implements ProductRepository {
  final dio = Dio();

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await dio.get("http://localhost:3031/products");
      final decoded = List.from(result.data);
      final products = decoded.map((e) => ProductModel.fromMap(e)).toList();

      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}

class UnoRepository implements ProductRepository {
  final uno = Uno();

  @override
  Future<List<ProductModel>> getProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final result = await uno.get('http://localhost:3031/products');
      final decoded = List.from(result.data);
      final products = decoded.map((e) => ProductModel.fromMap(e)).toList();

      return products;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
