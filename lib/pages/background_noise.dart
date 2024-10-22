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
    stop();
  }

  Future<bool> checkPermission() async => await Permission.microphone.isGranted;

  Future<void> requestPermission() async =>
      await Permission.microphone.request();

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
    return _latestReading?.meanDecibel != null &&
        _latestReading!.meanDecibel < 120;
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Noise Meter"),
            backgroundColor: Colors.blueAccent, // Custom AppBar color
            centerTitle: true,
          ),
          backgroundColor: Colors.blueGrey.shade100, // Subtle background color
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'BACKGROUND NOISE CALIBRATION',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/background.jpg', // Update image path if needed
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          _isRecording ? "Microphone: ON" : "Microphone: OFF",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                _isRecording ? Colors.redAccent : Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Noise Level: ${_latestReading?.meanDecibel != null ? _latestReading!.meanDecibel.toStringAsFixed(2) : "N/A"} dB',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            SystemNavigator.pop(); // Exit the app
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 30),
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Quit',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: _isRecording ? Colors.redAccent : Colors.green,
            onPressed: _isRecording ? stop : start,
            child: Icon(_isRecording ? Icons.stop : Icons.mic,
                size: 30, color: Colors.white),
          ),
        ),
        debugShowCheckedModeBanner: false, // Hide the debug banner
      );
}