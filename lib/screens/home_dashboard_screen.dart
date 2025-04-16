import 'package:flutter/material.dart';
import 'package:memotag_app/main.dart';
import 'package:memotag_app/screens/care_suggestion.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  final List<Map<String, dynamic>> _allPatients = [
    {"name": "John Doe", "age": 74, "status": "Stable"},
    {"name": "Maria Smith", "age": 68, "status": "Alert"},
    {"name": "Alex Roy", "age": 80, "status": "Critical"},
    {"name": "Rita Kapoor", "age": 72, "status": "Stable"},
  ];

  String _searchQuery = '';
  List<Map<String, dynamic>> _filteredPatients = [];

  @override
  void initState() {
    super.initState();
    _filteredPatients = _allPatients;
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _filteredPatients = _allPatients;
    });
  }

  void _updateSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredPatients = _allPatients.where((patient) {
        return patient['name'].toLowerCase().contains(_searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 12.0, bottom: 80),
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              builder: (_) => const CareSuggestionPopup(),
            );
          },
          backgroundColor: const Color(0xFF0057FF),
          elevation: 6,
          icon: const Icon(Icons.mic, size: 24, color: Colors.white),
          label: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Ask Memo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: const Color(0xFF0057FF),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0057FF),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome,',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            // SizedBox(height: 4),
                            Text(
                              'Dr. Aarti Sharma',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 130),
                        // Column(
                        //   children: [
                        Switch(
                          // splashRadius: 100,
                          value: themeNotifier.value == ThemeMode.dark,
                          onChanged: (val) {
                            themeNotifier.value =
                                val ? ThemeMode.dark : ThemeMode.light;
                          },
                          activeColor: Colors.white,
                        ),
                        // Switch(
                        //   value: themeNotifier == ThemeMode.dark,
                        //   onChanged: (val) {
                        //     themeNotifier.value =
                        //         val ? ThemeMode.dark : ThemeMode.light;
                        //   },
                        //   activeColor: Colors.white,
                        //   inactiveThumbColor: const Color(0xFF0057FF),
                        //   inactiveTrackColor: const Color(0xFFD0E9FF),
                        // ),

                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/profile'),
                          child: Hero(
                            tag: 'doctorProfile',
                            child: const CircleAvatar(
                              radius: 24,
                              backgroundImage: AssetImage('assets/doctor.png'),
                            ),
                          ),
                        ),
                        // ],
                        // ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Search Bar
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search,
                            color: Theme.of(context).primaryColorDark),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            onChanged: _updateSearch,
                            decoration: InputDecoration(
                              hintText: 'Search patients...',
                              hintStyle: TextStyle(
                                  color: Theme.of(context).primaryColorDark),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Patients',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  _filteredPatients.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            'No patients found',
                            style: TextStyle(
                              color: Color(0xFF4A4A4A),
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: _filteredPatients.length,
                          itemBuilder: (context, index) {
                            final patient = _filteredPatients[index];
                            final statusColor = patient['status'] == "Stable"
                                ? const Color(0xFF25D366)
                                : patient['status'] == "Alert"
                                    ? Colors.orange
                                    : Colors.red;

                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/patient_detail',
                                  arguments: patient,
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorLight,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Color(0xFF0B5FFF),
                                      child: Icon(Icons.person,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patient['name'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Age: ${patient['age']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        patient['status'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: statusColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
