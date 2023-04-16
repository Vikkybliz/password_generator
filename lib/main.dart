import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Password Generator',
      home: PasswordGenerator(),
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  final password_length = 8;
  final password_char =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890&&^+*()_+@#';
  String password = '';

  void generate() {
    final random = Random.secure();
    final generated = List.generate(password_length,
        (index) => password_char[random.nextInt(password_char.length)]);

    setState(() {
      password = generated.join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(password, style: const TextStyle(fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: generate, child: const Text('Generate password')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: password)).then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Password copied successfully'))));
                },
                child: const Text('Copy Password'))
          ],
        ),
      ),
    );
  }
}