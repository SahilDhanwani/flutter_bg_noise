import 'package:flutter/material.dart';
import 'package:environment_sound_meter/pages/background_noise.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to BackgroundNoise page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BackgroundNoise(),
              ),
            );
          },
          child: const Text('Go to Background Noise'),
        ),
      ),
    );
  }
}
