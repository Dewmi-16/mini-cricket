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
        useMaterial3: true,
      ),
      home: const MiniCricketPage(),
    );
  }
}

class MiniCricketPage extends StatefulWidget {
  const MiniCricketPage({super.key});

  @override
  State<MiniCricketPage> createState() => _MiniCricketPageState();
}

class _MiniCricketPageState extends State<MiniCricketPage> {
  final Random random = Random();

  final List<int> possibleRuns = [0, 1, 2, 3, 4, 6];

  int totalRuns = 0;
  int balls = 6;
  String result = '';

  void playBall() {
    if (balls <= 0) {
      return;
    }

    final int runsScored = possibleRuns[random.nextInt(possibleRuns.length)];

    setState(() {
      totalRuns = totalRuns + runsScored;
      balls = balls - 1;

      if (runsScored == 0) {
        result = 'No Runs';
      } else if (runsScored == 1) {
        result = '1 Run';
      } else {
        result = '$runsScored Runs';
      }
    });
  }

  void restartGame() {
    setState(() {
      totalRuns = 0;
      balls = 6;
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool gameIsRunning = balls > 0;

    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        title: const Text('Mini Cricket'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildScorePanel(
                  icon: Icons.sports_cricket,
                  label: 'Runs',
                  value: totalRuns,
                ),
                const SizedBox(width: 30),
                buildScorePanel(
                  icon: Icons.sports_baseball,
                  label: 'Balls',
                  value: balls,
                ),
              ],
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 30,
              child: Text(
                result,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: gameIsRunning ? playBall : restartGame,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    gameIsRunning ? Colors.blue.shade900 : Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 12,
                ),
              ),
              child: Text(
                gameIsRunning ? 'Bat' : 'Restart',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScorePanel({
    required IconData icon,
    required String label,
    required int value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          height: 120,
          color: Colors.white,
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 75,
            color: Colors.orange,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
