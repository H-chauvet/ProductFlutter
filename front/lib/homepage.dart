import 'package:flutter/material.dart';
import 'auth/register.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plateforme de E-commerce'),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Se connecter'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text("S'inscrire"),
          ),
          SizedBox(height: 20),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('Voir les articles'),
            ),
          ],
        ),
      ),
    );
  }
}
