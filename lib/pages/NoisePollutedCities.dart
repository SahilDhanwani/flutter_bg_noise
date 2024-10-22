import 'package:flutter/material.dart';

class NoisePollutedCities extends StatelessWidget {
  const NoisePollutedCities({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Updated static list of top 10 noise polluted cities with noise levels
    final List<Map<String, String>> cities = [
      {'city': 'Dhaka', 'country': 'Bangladesh', 'noise': '119 dB'},
      {'city': 'Moradabad', 'country': 'India', 'noise': '114 dB'},
      {'city': 'Islamabad', 'country': 'Pakistan', 'noise': '105 dB'},
      {'city': 'Rajshahi', 'country': 'Bangladesh', 'noise': '103 dB'},
      {'city': 'Ho Chi Minh City', 'country': 'Vietnam', 'noise': '103 dB'},
      {'city': 'Ibadan', 'country': 'Nigeria', 'noise': '101 dB'},
      {'city': 'Kupondole', 'country': 'Nepal', 'noise': '100 dB'},
      {'city': 'Algiers', 'country': 'Algeria', 'noise': '100 dB'},
      {'city': 'Bangkok', 'country': 'Thailand', 'noise': '99 dB'},
      {'city': 'New York', 'country': 'United States', 'noise': '95 dB'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top 10 Noise Polluted Cities'),
        backgroundColor: Colors.deepOrangeAccent, // Custom AppBar color
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (context, index) {
            final cityData = cities[index];
            return Card(
              elevation: 5, // Adds shadow to the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded edges
              ),
              margin: const EdgeInsets.symmetric(vertical: 8), // Adds space between cards
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 20), // Adds padding inside ListTile
                title: Text(
                  '${cityData['city']}, ${cityData['country']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Noise Level: ${cityData['noise']}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                leading: const Icon(
                  Icons.location_city,
                  color: Colors.blueAccent, // Icon representing city
                  size: 30,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
