import 'package:flutter/material.dart';

class VerbalFluencyCard extends StatelessWidget {
  final int wpm;
  final int change;

  const VerbalFluencyCard({super.key, required this.wpm, this.change = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          // colors: [Color(0xFFE6ECFF), Color(0xFFD2D0F4)],
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255)
          ],

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.record_voice_over_rounded,
            color: Color(0xFF0B5FFF),
            size: 36,
          ),
          const SizedBox(height: 10),
          Text(
            '$wpm WPM',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            change >= 0
                ? '+$change WPM vs last session'
                : '$change WPM vs last session',
            style: TextStyle(
              fontSize: 13,
              color: change >= 0 ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
