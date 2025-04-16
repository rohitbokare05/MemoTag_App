import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

Widget buildSessionCompletionCard(
    {required int completed, required int total}) {
  return _AnimatedSessionCompletionCard(completed: completed, total: total);
}

class _AnimatedSessionCompletionCard extends StatefulWidget {
  final int completed;
  final int total;

  const _AnimatedSessionCompletionCard({
    Key? key,
    required this.completed,
    required this.total,
  }) : super(key: key);

  @override
  State<_AnimatedSessionCompletionCard> createState() =>
      _AnimatedSessionCompletionCardState();
}

class _AnimatedSessionCompletionCardState
    extends State<_AnimatedSessionCompletionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    double completedFraction = widget.completed / widget.total;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _progress = Tween<double>(begin: 0, end: completedFraction).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, child) {
        final percentDone = (_progress.value * 100).toInt();

        return Container(
          height: 160,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD0E9FF), Color(0xFFB0C4FF)],
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
            children: [
              const Text(
                'Cognitive Sessions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 4,
                        centerSpaceRadius: 40,
                        startDegreeOffset: -90,
                        sections: [
                          PieChartSectionData(
                            color: const Color(0xFF0B5FFF),
                            value: _progress.value,
                            radius: 16,
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            color: Colors.grey.shade300,
                            value: 1 - _progress.value,
                            radius: 16,
                            showTitle: false,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$percentDone%',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D2D2D),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'done',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF4A4A4A)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline,
                      color: Colors.green, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    '${widget.completed}/${widget.total} sessions completed',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
