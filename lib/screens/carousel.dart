import 'package:flutter/material.dart';

class MoodCarouselCard extends StatelessWidget {
  final List<int> moodScores; // 1: sad, 2: neutral, 3: happy

  const MoodCarouselCard({super.key, required this.moodScores});

  @override
  Widget build(BuildContext context) {
    final moodData = [
      {'emoji': '😞', 'color': Colors.redAccent},
      {'emoji': '😐', 'color': Colors.orange},
      {'emoji': '🙂', 'color': Colors.green},
    ];
    final days = ['M', 'T', 'W', 'T', 'F', 'Sa', 'S'];
    final int todayIndex = DateTime.now().weekday % 7;

    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE6ECFF), Color(0xFFD2D0F4)],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'This Week\'s Mood',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moodScores.length,
              itemBuilder: (context, idx) {
                final m = moodScores[idx];
                final isToday = idx == todayIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (isToday)
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.25),
                          blurRadius: 16,
                          spreadRadius: 3,
                        ),
                    ],
                    border: isToday
                        ? Border.all(
                            color: Color(0xFF0B5FFF),
                            width: 3,
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: isToday ? 48 : 40,
                        height: isToday ? 48 : 40,
                        decoration: BoxDecoration(
                          color: (moodData[m - 1]['color'] as Color)
                              .withOpacity(isToday ? 0.9 : 0.6),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          moodData[m - 1]['emoji'] as String,
                          style: TextStyle(
                            fontSize: isToday ? 28 : 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        days[idx],
                        style: TextStyle(
                          fontWeight:
                              isToday ? FontWeight.bold : FontWeight.normal,
                          color:
                              isToday ? Color(0xFF0B5FFF) : Color(0xFF4A4A4A),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Mostly stable moods this week!',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4A4A4A),
            ),
          ),
        ],
      ),
    );
  }
}
