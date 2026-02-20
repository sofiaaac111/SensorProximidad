import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProximityScreen(),
    );
  }
}

class ProximityScreen extends StatefulWidget {
  const ProximityScreen({super.key});

  @override
  State<ProximityScreen> createState() => _ProximityScreenState();
}

class _ProximityScreenState extends State<ProximityScreen> {
  StreamSubscription<int>? _subscription;
  String _status = "Esperando sensor...";

  @override
  void initState() {
    super.initState();

    _subscription = ProximitySensor.events.listen((event) {
      setState(() {
        _status = event > 0
            ? "Objeto LEJOS del sensor"
            : "Objeto CERCA del sensor";
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _status.contains("CERCA") ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text("Sensor de Proximidad"),
      ),
      body: Center(
        child: Text(
          _status,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _status.contains("CERCA")
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}