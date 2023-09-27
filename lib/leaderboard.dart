import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class Player {
  final String name;
  final int score;

  Player({required this.name, required this.score});
}

class _LeaderboardState extends State<Leaderboard> {
  String myName = "You";
  double myScore = 1000;

  final List<Player> _players = [
    Player(name: "Bob", score: 90),
    Player(name: "Charlie", score: 80),
    Player(name: "Dave", score: 70),
    Player(name: "Eve", score: 60),
    Player(name: "Frank", score: 50),
    Player(name: "Grace", score: 40),
    Player(name: "Heidi", score: 30),
    Player(name: "So", score: 20),
    Player(name: "Bek", score: 10),
  ];

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  String getScoreString(int clicks) {
    if (clicks < 1000) {
      return clicks.toStringAsFixed(0);
    } else if (clicks < 1000000) {
      return "${(clicks / 1000).toStringAsFixed(2)}k";
    } else if (clicks < 1000000000) {
      return "${(clicks / 1000000).toStringAsFixed(2)}m";
    } else if (clicks < 1000000000000) {
      return "${(clicks / 1000000000).toStringAsFixed(2)}b";
    } else if (clicks < 1000000000000000) {
      return "${(clicks / 1000000000000).toStringAsFixed(2)}t";
    }
    return "Congrats! We haven't coded this yet...";
  }

  void asyncInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myScore = prefs.getDouble('score') ?? 0;
    _players.add(Player(name: myName, score: myScore.toInt()));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Sort the list of players based on their score
    _players.sort((a, b) => b.score.compareTo(a.score));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Leaderboard"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: ListView.builder(
            itemCount: _players.length,
            itemBuilder: (context, index) {
              final player = _players[index];
              final rank = index + 1;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Card(
                  elevation: player.name == myName ? 15 : 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text(
                          "$rank.",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            player.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Text(
                          getScoreString(player.score),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
