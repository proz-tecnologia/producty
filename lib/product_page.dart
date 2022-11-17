import 'package:flutter/material.dart';

import 'product_controller.dart';
import 'product_repository.dart';
import 'product_state.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.title});

  final String title;

  @override
  State<ProductPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProductPage> {
  final controller = ProductController(UnoRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (context, value, child) {
          switch (value.runtimeType) {
            case ProductsStateSuccess:
              return ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(controller.products[index].title),
                ),
              );
            case ProductsStateLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            default:
              return const Center(
                child: Text("Sem produtos no momento"),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getProducts(),
        child: const Icon(Icons.shuffle),
      ),
    );
  }
}
