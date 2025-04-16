import 'package:flutter/material.dart';

Widget buildHesitationRateCard({required int pauses}) {
  // Clamp the value between 0–20 for display
  double value = (pauses / 20).clamp(0.0, 1.0);

  // Color gradient based on severity
  Color barColor = pauses <= 7
      ? Colors.green
      : pauses <= 12
          ? Colors.orange
          : Colors.red;

  return Container(
    height: 160,
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
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
        Text(
          'Hesitation Rate',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D2D2D),
          ),
        ),
        const SizedBox(height: 10),

        const Icon(Icons.pause_circle_filled_rounded,
            color: Color(0xFF0B5FFF), size: 50),
        const SizedBox(height: 10),
        Text(
          '$pauses pauses/min',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D2D2D),
          ),
        ),
        // const SizedBox(height: 10),
        // Vertical hesitation meter
        // Container(
        //   width: 10,
        //   height: 60,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     color: Colors.grey.shade300,
        //   ),
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: AnimatedContainer(
        //       duration: const Duration(milliseconds: 800),
        //       height: 60 * value,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(12),
        //         color: barColor,
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 2),
        const Text(
          'Ideal: <10 pauses/min',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF4A4A4A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
