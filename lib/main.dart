import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SensorApp(),
    );
  }
}

class SensorApp extends StatelessWidget {
  const SensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 가로모드
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    // ]);

    final centerX = MediaQuery.of(context).size.width / 2 - 50;
    final centerY = MediaQuery.of(context).size.height / 2 - 50;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              color: Colors.red,
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2,
            top: 0,
            bottom: 0,
            child: Container(
              width: 1,
              color: Colors.red,
            ),
          ),
          StreamBuilder<AccelerometerEvent>(
              stream: accelerometerEventStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final event = snapshot.data!;
                return Positioned(
                  left: centerX + event.y * 20,
                  top: centerY + event.x * 20,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    width: 100,
                    height: 100,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
