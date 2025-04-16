import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:memotag_app/screens/animated_memory_recall.dart';
import 'package:memotag_app/screens/care_suggestion.dart';
import 'package:memotag_app/screens/carousel.dart';
import 'package:memotag_app/screens/hesitation_card.dart';
import 'package:memotag_app/screens/mood_card.dart';
import 'package:memotag_app/screens/session_report.dart';
import 'package:memotag_app/screens/step_counter.dart';
import 'package:memotag_app/screens/verbal_fluency_card.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class PatientDetailScreen extends StatefulWidget {
  const PatientDetailScreen({super.key});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      // Trigger any dummy refresh logic here
    });
  }

  @override
  Widget build(BuildContext context) {
    final patient =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF0057FF),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          '${patient['name']}\'s Health',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.picture_as_pdf, color: Colors.white),
                      tooltip: 'Upload PDF Report',
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          backgroundColor: Colors.white,
                          isScrollControlled: true,
                          builder: (_) => const Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.cloud_upload,
                                    size: 40, color: Color(0xFF0057FF)),
                                SizedBox(height: 12),
                                Text(
                                  'Upload Report (PDF)',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'This feature will allow doctors to upload diagnostic reports to patient records.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const TabBar(
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    indicatorSize: TabBarIndicatorSize
                        .tab, // Stretch indicator to full tab
                    indicatorPadding:
                        EdgeInsets.zero, // Remove internal padding
                    indicatorWeight: 0, // Prevent default underline

                    labelColor: Color(0xFF0057FF),
                    unselectedLabelColor: Colors.white70,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    tabs: [
                      Tab(
                        text: 'Cognitive Health',
                      ),
                      Tab(text: 'Physical Health'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
              onRefresh: _refreshData,
              color: const Color(0xFF0057FF),
              child: _buildCognitiveTab(),
            ),
            RefreshIndicator(
              onRefresh: _refreshData,
              color: const Color(0xFF0057FF),
              child: _buildPhysicalTab(),
            ),
          ],
        ),
        // ),
      ),
    );
  }

  // GRID: Cognitive KPIs
  Widget _buildCognitiveTab() {
    final List<Widget> cognitiveKpis = [
      AnimatedMemoryRecallCard(score: 0.72),
      VerbalFluencyCard(wpm: 48, change: 6),
      buildHesitationRateCard(pauses: 10),
      buildSentenceComplexityCard(level: 'Rich'),
      // MoodCarouselCard(moodScores: [2, 2, 3, 2, 2, 1, 3]),
      buildSessionCompletionCard(completed: 18, total: 20),
      MoodRingCard(moodLevel: 3),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        childAspectRatio: 0.95,
        children: cognitiveKpis,
      ),
    );
  }

  Widget buildMoodTrendCard() {
    final moods = [3, 2, 1, 2, 3]; // 1 = sad, 2 = neutral, 3 = happy
    final emojis = ['😞', '😐', '🙂'];

    return Container(
      height: 160,
      width: double.infinity,
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
          const Icon(Icons.emoji_emotions_rounded,
              color: Color(0xFF0B5FFF), size: 34),
          const SizedBox(height: 10),

          // Mood Line Chart
          SizedBox(
            height: 60,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final emoji = emojis[moods[value.toInt()] - 1];
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            emoji,
                            style: const TextStyle(fontSize: 16),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: moods
                        .asMap()
                        .entries
                        .map(
                            (e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                        .toList(),
                    isCurved: true,
                    dotData: FlDotData(show: false),
                    color: const Color(0xFF0B5FFF),
                    barWidth: 3,
                  )
                ],
                minY: 0.5,
                maxY: 3.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Mood is stable this week',
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

  Widget buildSentenceComplexityCard({required String level}) {
    final levels = ['Basic', 'Moderate', 'Advanced', 'Rich'];
    final int currentIndex = levels.indexOf(level);

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.auto_stories_rounded,
              color: Color(0xFF0B5FFF), size: 34),
          const SizedBox(height: 10),

          // Level badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFF0B5FFF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              level.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF0B5FFF),
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Step progress bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(levels.length, (index) {
              final isActive = index <= currentIndex;

              return Expanded(
                child: Container(
                  margin:
                      EdgeInsets.only(right: index < levels.length - 1 ? 6 : 0),
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: isActive
                        ? const LinearGradient(
                            colors: [Color(0xFF0B5FFF), Color(0xFF0057FF)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : LinearGradient(
                            colors: [Colors.white, Colors.white],
                          ),
                    border: Border.all(color: Color(0xFF0B5FFF), width: 1),
                  ),
                ),
              );
            }),
          ),

          const SizedBox(height: 12),
          const Text(
            'Rich structure = improved cognition',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF4A4A4A),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildMemoryRecallCard({required double score}) {
    int percent = (score * 100).round();

    return Container(
      height: 160,
      width: double.infinity,
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
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: score,
                  strokeWidth: 8,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF0B5FFF)),
                ),
              ),
              Column(
                children: [
                  Icon(Icons.psychology_alt,
                      color: Color(0xFF0B5FFF), size: 28),
                  const SizedBox(height: 4),
                  Text(
                    '$percent%',
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
          const SizedBox(height: 20),
          const Text(
            'Recall accuracy',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFallAlertCard({required int count}) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD1D1), Color(0xFFFF4E50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            '$count Falls',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'in last 30 days',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhysicalTab() {
    final List<Widget> physicalKpis = [
      _buildKpiCard('Sleep Hours', _buildSleepBarChart()),
      buildFallAlertCard(count: 2),
      buildGPSActivityCard(isSafe: true),
      _buildHeartRateGauge(100),
      buildStepProgressCard(steps: 8263, goal: 10000),
      buildEmergencyAlertCard(count: 1)
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        childAspectRatio: 0.95,
        children: physicalKpis,
      ),
    );
  }

  Widget buildEmergencyAlertCard({required int count}) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFD32F2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sensors, // or Icons.warning_amber_rounded
            color: Colors.white,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            '$count Emergency Alert${count > 1 ? 's' : ''}',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Requires immediate attention',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGPSActivityCard({bool isSafe = true}) {
    return Container(
      width: double.infinity,
      height: 160, // Square-like height
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isSafe
              ? [Color(0xFFB2F7B2), Color(0xFF25D366)] // safe green gradient
              : [Color(0xFFFFD1D1), Color(0xFFE53935)], // danger red gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: 36,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            isSafe ? 'Inside Safe Zone' : 'Outside Safe Zone',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Updated 5 min ago',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard(String title, Widget content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D))),
          ),
          const SizedBox(height: 12),
          content
        ],
      ),
    );
  }

  Widget _buildHeartRateGauge(int bpm) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            'Heart Rate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 40,
                  maximum: 180,
                  showLabels: false,
                  showTicks: false,
                  startAngle: 150,
                  endAngle: 30,
                  radiusFactor: 0.9,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 0.18,
                    color: Color(0xFFE0E0E0),
                    cornerStyle: CornerStyle.bothCurve,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: bpm.toDouble(),
                      width: 0.18,
                      sizeUnit: GaugeSizeUnit.factor,
                      color: Color(0xFF0B5FFF),
                      gradient: SweepGradient(
                        colors: [Color(0xFF0B5FFF), Color(0xFF0057FF)],
                      ),
                      cornerStyle: CornerStyle.bothCurve,
                      enableAnimation: true,
                      animationDuration: 1000,
                      animationType: AnimationType.ease,
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      positionFactor: 0,
                      angle: 90,
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '$bpm BPM',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          const Text(
                            'Live Tracking',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF4A4A4A),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          // const Text(
          //   'Live Tracking',
          //   style: TextStyle(
          //     fontSize: 15,
          //     color: Color(0xFF4A4A4A),
          //   ),
          // ),
        ],
      ),
    );
  }
}

Widget _buildSleepBarChart() => const _AnimatedSleepBarChart();

class _AnimatedSleepBarChart extends StatefulWidget {
  const _AnimatedSleepBarChart({super.key});

  @override
  State<_AnimatedSleepBarChart> createState() => _AnimatedSleepBarChartState();
}

class _AnimatedSleepBarChartState extends State<_AnimatedSleepBarChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<double> sleepHours = [5.2, 6.2, 5.6, 6.5, 5.2, 7.3, 8.0];

  int get _maxIndex {
    double max = sleepHours[0];
    int maxIdx = 0;
    for (int i = 1; i < sleepHours.length; i++) {
      if (sleepHours[i] > max) {
        max = sleepHours[i];
        maxIdx = i;
      }
    }
    return maxIdx;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BarChartRodData _buildRod(double value, int index) {
    final isMax = index == _maxIndex;
    return BarChartRodData(
      toY: value * _animation.value,
      width: 18,
      borderRadius: BorderRadius.circular(6),
      gradient: const LinearGradient(
        colors: [Color(0xFF0B5FFF), Color(0xFF6A5ACD)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      rodStackItems: [],
      // Add shadow glow if it's the max bar
      backDrawRodData: isMax
          ? BackgroundBarChartRodData(
              show: true,
              toY: value * _animation.value,
              color: Colors.transparent,
              // borderRadius: BorderRadius.circular(6),
              gradient: RadialGradient(
                center: Alignment.center,
                colors: [
                  Colors.blue.withOpacity(0.25),
                  Colors.transparent,
                ],
                radius: 1.2,
              ),
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return SizedBox(
          height: 140,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipRoundedRadius: 12,
                  tooltipPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  tooltipMargin: 8,
                  tooltipBgColor: const Color(0xFF1C1C1E),
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    const days = [
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat',
                      'Sun'
                    ];
                    return BarTooltipItem(
                      '${days[group.x]}\n',
                      const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                      children: [
                        TextSpan(
                          text: '${rod.toY.toStringAsFixed(1)} ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const TextSpan(
                          text: 'hrs',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 22,
                    getTitlesWidget: (value, _) {
                      const days = ['M', 'T', 'W', 'T', 'F', 'Sa', 'S'];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          days[value.toInt()],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4A4A4A),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(sleepHours.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [_buildRod(sleepHours[index], index)],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
