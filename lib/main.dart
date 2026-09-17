import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MiniCricketApp());
}

class MiniCricketApp extends StatelessWidget {
  const MiniCricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Cricket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CricketPage(),
    );
  }
}

class CricketPage extends StatefulWidget {
  const CricketPage({super.key});

  @override
  State<CricketPage> createState() => _CricketPageState();
}

class _CricketPageState extends State<CricketPage> {
  int totalRuns = 0;
  int balls = 6;
  int? lastRuns;

  final Random random = Random();

  void bat() {
    if (balls == 0) {
      restart();
      return;
    }

    setState(() {
      lastRuns = random.nextInt(7); // Produces a value from 0 to 6
      totalRuns += lastRuns!;
      balls--;
    });
  }

  void restart() {
    setState(() {
      totalRuns = 0;
      balls = 6;
      lastRuns = null;
    });
  }

  String get resultMessage {
    if (lastRuns == null) {
      return '';
    }

    if (lastRuns == 0) {
      return 'No Runs';
    }

    if (lastRuns == 1) {
      return '1 Run';
    }

    return '$lastRuns Runs';
  }

  @override
  Widget build(BuildContext context) {
    final gameOver = balls == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mini Cricket',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      backgroundColor: Colors.blue.shade600,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                scoreCard(symbol: '🏏', label: 'Runs', value: totalRuns),
                const SizedBox(width: 24),
                scoreCard(symbol: '🔴', label: 'Balls', value: balls),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 30,
              child: Text(
                resultMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: bat,
              style: ElevatedButton.styleFrom(
                backgroundColor: gameOver ? Colors.red : Colors.blue.shade900,
                foregroundColor: Colors.white,
              ),
              child: Text(gameOver ? 'Restart' : 'Bat'),
            ),
          ],
        ),
      ),
    );
  }

  Widget scoreCard({
    required String symbol,
    required String label,
    required int value,
  }) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          color: Colors.white,
          alignment: Alignment.center,
          child: Text(symbol, style: const TextStyle(fontSize: 70)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
