// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'auth/register.dart';
import 'auth/login.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';
import 'product/product_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue ${user.username}'),
        actions: [
          if (user.username != '')
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductListPage()),
                );
              },
              child: const Text('Voir les articles'),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('Se connecter'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterPage()),
              );
            },
            child: const Text("S'inscrire"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
