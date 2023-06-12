// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String errorMessage = '';

  Future<void> register() async {
    final String username = usernameController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (password.length < 8) {
      setState(() {
        errorMessage = 'Le mot de passe doit contenir au moins 8 caractères.';
      });
    } else if (password != confirmPassword) {
      setState(() {
        errorMessage = 'Les mots de passe ne correspondent pas.';
      });
    } else {
      final Map<String, dynamic> userData = {
        'username': username,
        'password': password,
        'confirmPassword': confirmPassword,
      };

      final Uri url = Uri.parse('http://localhost:3000/api/auth/register');
      final response = await http.post(
        url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: 'Inscription réussie!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        usernameController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Erreur lors de l\'inscription: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text("Se connecter"),
          ),
          const SizedBox(height: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: FractionallySizedBox(
                widthFactor:
                    0.5, // Réduit la largeur à 50% de la largeur du parent
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom d\'utilisateur',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: FractionallySizedBox(
                widthFactor:
                    0.5, // Réduit la largeur à 50% de la largeur du parent
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: FractionallySizedBox(
                widthFactor:
                    0.5, // Réduit la largeur à 50% de la largeur du parent
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmer le mot de passe',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: const Text('S\'inscrire'),
            ),
            const SizedBox(height: 10),
            Text(
              errorMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
