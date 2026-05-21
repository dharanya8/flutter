// lib/screens/sport_list_screen.dart
import 'package:flutter/material.dart';

class SportListScreen extends StatelessWidget {
  final String sportName;

  const SportListScreen({super.key, required this.sportName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sportName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF1A1A2E)],
          ),
        ),
        child: Column(
          children: [
            // Sport header
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.withOpacity(0.2), Colors.grey[900]!],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    sportName == 'Cricket'
                        ? Icons.sports_cricket
                        : Icons.sports_tennis,
                    size: 50,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sportName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Upcoming Matches & Tournaments',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Matches list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _getMatchesForSport(sportName).length,
                itemBuilder: (context, index) {
                  final match = _getMatchesForSport(sportName)[index];
                  return _buildMatchCard(match);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: match['type'] == 'Match'
                        ? Colors.orange.withOpacity(0.2)
                        : Colors.purple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: match['type'] == 'Match'
                          ? Colors.orange
                          : Colors.purple,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    match['type'],
                    style: TextStyle(
                      fontSize: 12,
                      color: match['type'] == 'Match'
                          ? Colors.orange
                          : Colors.purpleAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(width: 4),
                Text(
                  match['date'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              match['title'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  match['venue'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTeamInfo(match['team1']),
                const Text(
                  'VS',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTeamInfo(match['team2']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamInfo(String teamName) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.sports_baseball,
              color: Colors.orange.withOpacity(0.7),
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            teamName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMatchesForSport(String sportName) {
    if (sportName == 'Cricket') {
      return [
        {
          'type': 'Match',
          'date': 'May 20, 2026 • 10:00 AM',
          'title': 'India vs Australia',
          'venue': 'Wankhede Stadium, Mumbai',
          'team1': 'India',
          'team2': 'Australia',
        },
        {
          'type': 'Match',
          'date': 'May 22, 2026 • 2:00 PM',
          'title': 'England vs South Africa',
          'venue': 'Lord\'s, London',
          'team1': 'England',
          'team2': 'South Africa',
        },
        {
          'type': 'Tournament',
          'date': 'Jun 1-15, 2026',
          'title': 'IPL 2026 Playoffs',
          'venue': 'Multiple Venues',
          'team1': 'TBD',
          'team2': 'TBD',
        },
        {
          'type': 'Match',
          'date': 'May 25, 2026 • 7:00 PM',
          'title': 'Pakistan vs New Zealand',
          'venue': 'Gaddafi Stadium, Lahore',
          'team1': 'Pakistan',
          'team2': 'New Zealand',
        },
      ];
    } else {
      return [
        {
          'type': 'Match',
          'date': 'May 21, 2026 • 9:00 AM',
          'title': 'US Open Pickleball',
          'venue': 'Naples, Florida',
          'team1': 'Ben Johns',
          'team2': 'Tyson McGuffin',
        },
        {
          'type': 'Tournament',
          'date': 'May 23-25, 2026',
          'title': 'PPA Tour - Seattle',
          'venue': 'Seattle, Washington',
          'team1': 'Anna Bright',
          'team2': 'Lea Jansen',
        },
        {
          'type': 'Match',
          'date': 'May 28, 2026 • 1:00 PM',
          'title': 'World Pickleball Championship',
          'venue': 'Las Vegas, Nevada',
          'team1': 'JW Johnson',
          'team2': 'Dylan Frazier',
        },
        {
          'type': 'Tournament',
          'date': 'Jun 5-7, 2026',
          'title': 'MLP Mid-Season',
          'venue': 'Orlando, Florida',
          'team1': 'Orlando Squeeze',
          'team2': 'LA Mad Drops',
        },
      ];
    }
  }
}
