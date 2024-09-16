import 'dart:async';
import 'package:noise_meter/noise_meter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class BackgroundNoise extends StatefulWidget {
  const BackgroundNoise({super.key});

  @override
  BackgroundNoiseState createState() => BackgroundNoiseState();
}

class BackgroundNoiseState extends State<BackgroundNoise> {
  bool _isRecording = false;
  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      _latestReading = noiseReading;
    });
  }

  void onError(Object error) {
    // print(error);
    stop();
  }

  Future<bool> checkPermission() async => await Permission.microphone.isGranted;

  Future<void> requestPermission() async => await Permission.microphone.request();

  Future<void> start() async {
    noiseMeter ??= NoiseMeter();

    if (!(await checkPermission())) await requestPermission();

    _noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
    setState(() {
      _isRecording = true;
    });
  }

  void stop() {
    _noiseSubscription?.cancel();
    setState(() {
      _isRecording = false;
    });
  }

  bool isNoiseBelowThreshold() {
    return _latestReading?.meanDecibel != null && _latestReading!.meanDecibel < 120;
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.blueGrey.shade100,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BACKGROUND NOISE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'CALIBRATION',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/baground.jpg',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                Card(
                  margin: const EdgeInsets.all(25),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          _isRecording ? "Microphone: ON" : "Microphone: OFF",
                          style: TextStyle(
                            fontSize: 20,
                            color: _isRecording ? Colors.red : Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Noise Level: ${_latestReading?.meanDecibel != null ? _latestReading!.meanDecibel.toStringAsFixed(2) : "N/A"} dB',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            SystemNavigator.pop(); // Exit the app
                          },
                          child: const Text('Quit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: _isRecording ? Colors.red : Colors.green,
            onPressed: _isRecording ? stop : start,
            child: _isRecording ? const Icon(Icons.stop) : const Icon(Icons.mic),
          ),
        ),
      );
}
