import 'package:flutter/material.dart';
import 'package:untitled1/screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/sportsdetailpage.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final String phone;

  const HomeScreen({super.key, required this.name, required this.phone});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;
  String selected = "All";

  late AnimationController _animationController;

  final List<Map<String, String>> matches = [
    {
      "sport": "Cricket",
      "title": "Cricket League",
      "desc": "Join exciting cricket battles",
      "date": "20 May 2026",
      "time": "10:00 AM",
      "venue": "M.A. Chidambaram Stadium",
      "img": "https://images.unsplash.com/photo-1531415074968-036ba1b575da",
    },

    {
      "sport": "Pickleball",
      "title": "Pickleball Cup",
      "desc": "Fast growing sport event",
      "date": "22 May 2026",
      "time": "2:00 PM",
      "venue": "SDAT Tennis Stadium",
      "img":
          "https://cdn.mos.cms.futurecdn.net/Spgo5rGoUCJC4ThbZx8fAh-1920-80.jpg",
    },

    {
      "sport": "Carrom",
      "title": "Carrom Masters",
      "desc": "Indoor championship event",
      "date": "25 May 2026",
      "time": "4:00 PM",
      "venue": "Nehru Indoor Stadium",
      "img":
          "https://static.vecteezy.com/system/resources/previews/000/182/357/original/vector-carrom-board-game.jpg",
    },

    {
      "sport": "Badminton",
      "title": "Badminton Smash",
      "desc": "Fast shuttle matches",
      "date": "28 May 2026",
      "time": "6:00 PM",
      "venue": "Jawaharlal Stadium",
      "img":
          "https://th.bing.com/th/id/R.b53d16153919e08d9e565c3ffd1084c7?rik=ZuJ9XH93J2Niog&riu=http%3a%2f%2fd.ibtimes.co.uk%2fen%2ffull%2f1531890%2fbadminton.jpg&ehk=uiSGJ1JfKaanJmBPnZCnNhONwhC9EmD%2busfHoL8hUCg%3d&risl=&pid=ImgRaw&r=0",
    },
  ];

  List<Map<String, String>> get filtered => selected == "All"
      ? matches
      : matches.where((e) => e["sport"] == selected).toList();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color(0xFF111827),

        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4185EA), Color(0xFF36BAF3)],
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,

                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xFF4185EA),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.phone,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // 🏠 HOME
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white),
              title: const Text("Home", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // 🏆 TOURNAMENTS
            ListTile(
              leading: const Icon(Icons.emoji_events, color: Colors.white),
              title: const Text(
                "Tournaments",
                style: TextStyle(color: Colors.white),
              ),

              onTap: () {},
            ),
            // 👤 PROFILE
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),

              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProfileScreen(name: widget.name, phone: widget.phone),
                  ),
                );
              },
            ),
            // 🚪 LOGOUT
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.redAccent),
              ),

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF070B1A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: Container(
          margin: const EdgeInsets.all(8),

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4185EA), Color(0xFF36BAF3)],
            ),

            shape: BoxShape.circle,
          ),

          child: const Icon(Icons.sports_soccer, color: Colors.white),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "ToTo Sports",

              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Welcome ${widget.name.split(' ')[0]}",

              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },

              icon: const Icon(Icons.menu, color: Colors.white),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 🔥 TOP BANNER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Container(
                height: 210,
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),

                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?w=800",
                    ),

                    fit: BoxFit.cover,
                  ),
                ),

                child: Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),

                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.75),
                      ],
                    ),
                  ),

                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Text(
                        "SPORTS FESTIVAL 2026",

                        style: TextStyle(
                          color: Color(0xFF36BAF3),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        "Play Like A Champion",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 16,
                          ),

                          SizedBox(width: 5),

                          Text(
                            "Chennai, India",

                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 FILTER CHIPS
            SizedBox(
              height: 50,

              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),

                children: [
                  _chip("All"),
                  _chip("Cricket"),
                  _chip("Pickleball"),
                  _chip("Carrom"),
                  _chip("Badminton"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 CARDS
            Column(
              children: filtered.map((item) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,

                      colors: [Color(0xFF131B2E), Color(0xFF0A0E27)],
                    ),

                    borderRadius: BorderRadius.circular(28),

                    border: Border.all(color: Colors.white.withOpacity(0.05)),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // 🔥 IMAGE
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(28),
                            ),

                            child: Image.network(
                              item["img"]!,
                              height: 210,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Container(
                            height: 210,

                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(28),
                              ),

                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,

                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            top: 18,
                            left: 18,

                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 7,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),

                                borderRadius: BorderRadius.circular(30),
                              ),

                              child: Text(
                                item["sport"]!,

                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: 20,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  item["title"]!,

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  item["desc"]!,

                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // 🔥 DETAILS
                      Padding(
                        padding: const EdgeInsets.all(20),

                        child: Column(
                          children: [
                            _modernRow(
                              Icons.calendar_month_rounded,
                              item["date"]!,
                            ),

                            const SizedBox(height: 14),

                            _modernRow(
                              Icons.access_time_rounded,
                              item["time"]!,
                            ),

                            const SizedBox(height: 14),

                            _modernRow(
                              Icons.location_on_rounded,
                              item["venue"]!,
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              height: 55,

                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          SportsDetailPage(data: item),
                                    ),
                                  );
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4185EA),

                                  elevation: 0,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),

                                child: const Text(
                                  "Register Now",

                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF111827),

        currentIndex: index,

        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white54,

        onTap: (i) {
          setState(() => index = i);

          if (i == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ProfileScreen(name: widget.name, phone: widget.phone),
              ),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),

          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // 🔥 CHIP
  Widget _chip(String text) {
    final isSel = selected == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = text;
        });
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),

        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),

        decoration: BoxDecoration(
          gradient: isSel
              ? const LinearGradient(
                  colors: [Color(0xFF4185EA), Color(0xFF36BAF3)],
                )
              : null,

          color: isSel ? null : Colors.lightBlueAccent,

          borderRadius: BorderRadius.circular(30),
        ),

        child: Center(
          child: Text(
            text,

            style: TextStyle(
              color: isSel ? Colors.white : Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 MODERN ROW
  Widget _modernRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.12),

            borderRadius: BorderRadius.circular(14),
          ),

          child: Icon(icon, color: Colors.blueAccent, size: 20),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            text,

            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
