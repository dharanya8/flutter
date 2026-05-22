import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  final String sport;
  final String team;
  final String amount;
  final String matchType;
  final String venue;
  final String date;
  final String time;

  const SuccessPage({
    super.key,
    required this.sport,
    required this.team,
    required this.amount,
    required this.matchType,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  final TextEditingController phoneController = TextEditingController();

  String selectedTeam = "";

  // 🏏 Cricket Teams
  final List<String> cricketTeams = [
    "Erode Eagles",
    "Chennai Titans",
    "Coimbatore Kings",
    "Madurai Warriors",
    "Salem Strikers",
  ];

  // 🎾 Pickleball Teams
  final List<String> pickleballTeams = [
    "Smash Masters",
    "Paddle Kings",
    "Court Warriors",
    "Spin Strikers",
  ];

  // 🪵 Carrom Teams
  final List<String> carromTeams = [
    "Pocket Masters",
    "Queen Strikers",
    "Board Kings",
    "Carrom Champs",
  ];

  // 🏸 Badminton Teams
  final List<String> badmintonTeams = [
    "Shuttle Stars",
    "Smash Bros",
    "Net Ninjas",
    "Rapid Racquets",
  ];
  // 🌍 DISTRICTS
  final List<String> districts = ["Chennai", "Coimbatore", "Erode", "Madurai"];

  String selectedDistrict = "Chennai";

  // 📞 DISTRICT CODES
  Map<String, String> districtCodes = {
    "Chennai": "044",
    "Coimbatore": "0422",
    "Erode": "0424",
    "Madurai": "0452",
  };

  // 🔥 Dynamic Team List
  List<String> get teams {
    switch (widget.sport) {
      case "Cricket":
        return cricketTeams;

      case "Pickleball":
        return pickleballTeams;

      case "Carrom":
        return carromTeams;

      case "Badminton":
        return badmintonTeams;

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081221),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // 🏆 SPORT NAME
              Center(
                child: Text(
                  widget.sport,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // 📄 DETAILS CARD
              _infoCard("📅 Date", widget.date),
              _infoCard("⏰ Time", widget.time),
              _infoCard("📍 Venue", widget.venue),
              _infoCard("💰 Amount", widget.amount),

              const SizedBox(height: 30),

              // 👥 TEAM TITLE
              const Text(
                "Select Team",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // 🔥 MODERN DROPDOWN
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 4,
                ),

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.08),
                      Colors.white.withOpacity(0.03),
                    ],
                  ),

                  borderRadius: BorderRadius.circular(18),

                  border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // dropdownColor: const Color(0xFF102038),
                    borderRadius: BorderRadius.circular(18),

                    isExpanded: true,
                    value: selectedTeam.isEmpty ? null : selectedTeam,

                    hint: const Row(
                      children: [
                        Icon(Icons.groups, color: Colors.blueAccent),

                        SizedBox(width: 10),

                        Text(
                          "Choose Team",

                          // style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      ],
                    ),

                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.blueAccent,
                      size: 28,
                    ),

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),

                    items: teams.map((team) {
                      return DropdownMenuItem(
                        value: team,

                        child: Row(
                          children: [
                            const Icon(
                              Icons.sports,
                              color: Colors.blueAccent,
                              size: 20,
                            ),

                            const SizedBox(width: 10),

                            Text(team),
                          ],
                        ),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedTeam = value!;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Select District",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedDistrict,
                    dropdownColor: const Color(0xFF102038),
                    isExpanded: true,

                    style: const TextStyle(color: Colors.white, fontSize: 16),

                    items: districts.map((district) {
                      return DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value!;
                      });
                    },
                  ),
                ),
              ),
              // 📱 PHONE NUMBER
              const Text(
                "Mobile Number",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  // 🔥 CODE DROPDOWN
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(18),

                      border: Border.all(
                        color: Colors.blueAccent.withOpacity(0.3),
                      ),
                    ),

                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedDistrict,

                        dropdownColor: const Color(0xFF102038),

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),

                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blueAccent,
                        ),

                        items: districts.map((district) {
                          return DropdownMenuItem(
                            value: district,

                            child: Text(districtCodes[district]!),
                          );
                        }).toList(),

                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value!;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // 📱 PHONE FIELD
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,

                      style: const TextStyle(color: Colors.white, fontSize: 16),

                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",

                        hintStyle: const TextStyle(color: Colors.white38),

                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.blueAccent,
                        ),

                        filled: true,
                        fillColor: Colors.white.withOpacity(0.05),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // 🔥 REGISTER BUTTON
              SizedBox(
                width: double.infinity,
                height: 60,

                child: ElevatedButton(
                  onPressed: () {
                    // ❌ TEAM EMPTY
                    if (selectedTeam.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Please Select Team"),
                        ),
                      );

                      return;
                    }

                    // ❌ PHONE EMPTY
                    if (phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Please Enter Mobile Number"),
                        ),
                      );

                      return;
                    }

                    // ✅ SUCCESS POPUP
                    showDialog(
                      context: context,

                      builder: (_) {
                        return AlertDialog(
                          backgroundColor: const Color(0xFF102038),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                          title: const Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),

                              SizedBox(width: 10),

                              Text(
                                "Success",

                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),

                          content: Text(
                            "$selectedTeam Registered Successfully",

                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            ),
                          ),

                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.popUntil(
                                  context,
                                  (route) => route.isFirst,
                                );
                              },

                              child: const Text(
                                "OK",

                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,

                    elevation: 10,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  child: const Text(
                    "Register Now",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 INFO CARD
  Widget _infoCard(String title, String value) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 15),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            title,

            style: const TextStyle(color: Colors.white70, fontSize: 15),
          ),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,

              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
