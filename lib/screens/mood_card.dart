import 'package:flutter/material.dart';

class MoodRingCard extends StatelessWidget {
  final int moodLevel; // 1 = sad, 2 = neutral, 3 = happy

  const MoodRingCard({super.key, this.moodLevel = 2});

  @override
  Widget build(BuildContext context) {
    final emojiMap = {1: '😞', 2: '😐', 3: '🙂'};
    final moodText = {
      1: 'Feeling low today',
      2: 'Mood is stable',
      3: 'Great mood today!'
    };
    final gradientMap = {
      1: [Colors.red.shade100, Colors.red.shade300],
      2: [Colors.orange.shade100, Colors.orange.shade400],
      3: [Colors.green.shade100, const Color(0xFF25D366)]
    };

    return Container(
      height: 170,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientMap[moodLevel]!,
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
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      gradientMap[moodLevel]![1].withOpacity(0.6),
                      gradientMap[moodLevel]![0].withOpacity(0.8),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: gradientMap[moodLevel]![1].withOpacity(0.4),
                      blurRadius: 16,
                      spreadRadius: 4,
                    )
                  ],
                ),
              ),
              Text(
                emojiMap[moodLevel]!,
                style: const TextStyle(fontSize: 36),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            moodText[moodLevel]!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
            ),
          )
        ],
      ),
    );
  }
}
