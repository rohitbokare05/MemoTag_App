import 'package:flutter/material.dart';

class CareSuggestionPopup extends StatelessWidget {
  const CareSuggestionPopup({super.key});

  final List<String> suggestions = const [
    "🧠 Encourage memory games for John this week.",
    "💬 Try short storytelling exercises with Maria.",
    "📱 Schedule a caregiver video call for Alex.",
    "🚶 Suggest a short supervised walk for Rita.",
    "🎵 Use familiar music for calming sessions.",
    "📔 Ask patients to recall recent events daily.",
    "🛏️ Ensure consistent sleep routines post 9 PM.",
    "🍎 Track nutrition changes over the next 3 days.",
    "🔔 Check if cognitive sessions were missed.",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(Icons.keyboard_voice_rounded,
                color: Color(0xFF0057FF), size: 32),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Care Suggestions by Memo 🤖",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: suggestions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Text(
                    suggestions[index],
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B5FFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.done, color: Colors.white),
              label: const Text(
                "Got it!",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
