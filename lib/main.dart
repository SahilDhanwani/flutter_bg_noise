import 'package:environment_sound_meter/pages/NoisePollutedCities.dart';
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
        scaffoldBackgroundColor: Colors.blueGrey[50], // Light background
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          titleSmall: TextStyle(fontSize: 18),
        ),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false, // Removes the debug banner
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
        backgroundColor: Colors.blueAccent, // Customize AppBar color
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(16.0), // Adds padding around the buttons
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Background Noise Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BackgroundNoise(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Button color
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 30), // Larger button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Go to Background Noise',
                  style: TextStyle(fontSize: 18), // Larger font size
                ),
              ),
              const SizedBox(height: 20), // Adds space between buttons
              // Top 10 Noise Polluted Cities Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NoisePollutedCities(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepOrangeAccent, // Custom button color
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 30), // Larger button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Top 10 Noise Polluted Cities',
                  style: TextStyle(fontSize: 18), // Larger font size
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
