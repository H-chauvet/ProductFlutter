// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'product_create.dart';
import 'product_edit.dart';
import 'widget/product_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> deleteProduct(Product product) async {
    final Uri url = Uri.parse("http://localhost:3000/api/product/delete");
    final response = await http.post(
      url,
      body: json.encode({'id': product.id}),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Produit supprimé avec succès',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      fetchProducts();
    } else {
      Fluttertoast.showToast(
        msg: 'Erreur lors de la suppression du produit: ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void editProduct(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(product: product),
      ),
    );
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/product/list'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> productsData = responseData["products"];
      setState(() {
        products = productsData.map((data) => Product.fromJson(data)).toList();
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Erreur lors de la récupération: ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateProductPage()),
              );
            },
            child: const Text("Créer un produit"),
          ),
          const SizedBox(height: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onDelete: deleteProduct,
            onEdit: editProduct,
          );
        },
      ),
    );
  }
}
