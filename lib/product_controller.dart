// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:producty/product_model.dart';
import 'package:producty/product_repository.dart';
import 'package:producty/product_state.dart';

class ProductController {
  final ProductRepository _repository;

  ProductController(this._repository);

  final ValueNotifier<ProductsState> state =
      ValueNotifier(ProductsStateInitial());

  late List<ProductModel> _products;

  List<ProductModel> get products => _products;

  Future<void> getProducts() async {
    state.value = ProductsStateLoading();
    try {
      _products = await _repository.getProducts();
      state.value = ProductsStateSuccess();
    } catch (e) {
      state.value = ProductsStateError();
    }
  }
}
