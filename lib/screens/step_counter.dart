import 'package:flutter/material.dart';

Widget buildStepProgressCard({required int steps, int goal = 10000}) {
  return _AnimatedStepProgressCard(steps: steps, goal: goal);
}

class _AnimatedStepProgressCard extends StatefulWidget {
  final int steps;
  final int goal;

  const _AnimatedStepProgressCard(
      {super.key, required this.steps, required this.goal});

  @override
  State<_AnimatedStepProgressCard> createState() =>
      _AnimatedStepProgressCardState();
}

class _AnimatedStepProgressCardState extends State<_AnimatedStepProgressCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<int> _stepCountAnimation;

  @override
  void initState() {
    super.initState();
    double progress = widget.steps / widget.goal;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _progressAnimation =
        Tween<double>(begin: 0, end: progress.clamp(0.0, 1.0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _stepCountAnimation = IntTween(begin: 0, end: widget.steps).animate(
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
      animation: _controller,
      builder: (context, child) {
        final progress = _progressAnimation.value;
        final currentSteps = _stepCountAnimation.value;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Step Count',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 8,
                      backgroundColor: const Color(0xFFE0E0E0),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF0B5FFF)),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.directions_walk,
                          color: Color(0xFF0B5FFF), size: 26),
                      const SizedBox(height: 4),
                      Text(
                        '$currentSteps',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Goal: ${widget.goal}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A4A4A),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
