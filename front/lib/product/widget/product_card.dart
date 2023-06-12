import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) onDelete;
  final Function(Product) onEdit;

  const ProductCard({required this.product, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(product.name),
            subtitle: Text(product.description),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => onEdit(product),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => onDelete(product),
                ),
              ],
            ),
          ),
          Text('Price: ${product.price}'),
        ],
      ),
    );
  }
}
