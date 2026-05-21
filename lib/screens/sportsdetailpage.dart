import 'package:flutter/material.dart';
import 'success_page.dart';

class SportsDetailPage extends StatelessWidget {
  final Map<String, String> data;

  const SportsDetailPage({super.key, required this.data});

  // 💰 Amount
  String get amount {
    if (data["sport"] == "Cricket") {
      return "₹1500";
    }
    return "₹500";
  }

  // 📄 About Sports
  String get aboutSport {
    String sport = data["sport"]!;

    if (sport == "Cricket") {
      return "Cricket is one of the most popular team sports played with bat and ball. Enjoy thrilling matches and exciting tournaments.";
    }

    if (sport == "Pickleball") {
      return "Pickleball is a fast growing paddle sport combining tennis, badminton and table tennis.";
    }

    if (sport == "Carrom") {
      return "Carrom is an indoor strategy game requiring focus and precision.";
    }

    if (sport == "Badminton") {
      return "Badminton is a high-speed racket sport played with shuttlecock.";
    }

    return "Enjoy exciting sports tournaments.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081221),

      body: Stack(
        children: [
          // 🔥 MAIN CONTENT
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 TOP IMAGE
                Stack(
                  children: [
                    Container(
                      height: 320,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data["img"]!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Container(
                      height: 320,

                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,

                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                    ),

                    // 🔙 BACK BUTTON
                    Positioned(
                      top: 50,
                      left: 15,

                      child: CircleAvatar(
                        backgroundColor: Colors.black45,

                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // 🏆 TITLE
                    Positioned(
                      bottom: 30,
                      left: 20,
                      right: 20,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            data["sport"]!,

                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            data["title"]!,

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // 📄 ABOUT TOURNAMENT
                _sectionTitle("About Tournament"),

                _modernCard(
                  child: Text(
                    data["desc"]!,

                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),
                ),

                // 🏏 ABOUT SPORT
                _sectionTitle("About ${data["sport"]}"),

                _modernCard(
                  child: Text(
                    aboutSport,

                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),
                ),

                // 📅 EVENT DETAILS
                _sectionTitle("Event Details"),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  child: Column(
                    children: [
                      _detailCard(Icons.calendar_month, "Date", data["date"]!),

                      const SizedBox(height: 12),

                      _detailCard(Icons.access_time, "Time", data["time"]!),

                      const SizedBox(height: 12),

                      _detailCard(Icons.location_on, "Venue", data["venue"]!),

                      const SizedBox(height: 12),

                      _detailCard(
                        Icons.currency_rupee,
                        "Registration Amount",
                        amount,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),

          // 🔥 REGISTER BUTTON
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: SizedBox(
              height: 60,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SuccessPage(
                        sport: data["sport"]!,
                        amount: amount,
                        venue: data["venue"]!,
                        date: data["date"]!,
                        time: data["time"]!,
                      ),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 10,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                child: Text(
                  "Register Now • $amount",

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 SECTION TITLE
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),

      child: Text(
        title,

        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 🔹 MODERN CARD
  Widget _modernCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),

        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),

      child: child,
    );
  }

  // 🔹 DETAIL CARD
  Widget _detailCard(IconData icon, String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),

        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(0.2),

            child: Icon(icon, color: Colors.blueAccent),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
