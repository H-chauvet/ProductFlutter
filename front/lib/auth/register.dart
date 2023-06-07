import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
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
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Erreur lors de l\'inscription: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmer le mot de passe',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: Text('S\'inscrire'),
            ),
            SizedBox(height: 10),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
