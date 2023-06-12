// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myflutter/homepage.dart';
import 'register.dart';
import 'package:provider/provider.dart';
import '../user/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> login() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    if (username.isEmpty) {
      setState(() {
        errorMessage = "Veuillez saisir votre nom d'utilisteur";
      });
    } else if (password.isEmpty) {
      setState(() {
        errorMessage = "Veuillez saisir votre mot de passe";
      });
    } else {
      final Map<String, dynamic> userData = {
        'username': username,
        'password': password,
      };

      final Uri url = Uri.parse("http://localhost:3000/api/auth/login");
      final response = await http.post(
        url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Connexion réussie!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final user = User(username);
        userProvider.setUser(user);

        usernameController.clear();
        passwordController.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Erreur lors de la connexion: ${response.statusCode}',
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
        title: const Text('Connexion'),
        actions: [
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.5, // Définit la largeur à la moitié de la largeur de l'écran
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
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.5, // Définit la largeur à la moitié de la largeur de l'écran
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
            ElevatedButton(
              onPressed: login,
              child: const Text('Se connecter'),
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
