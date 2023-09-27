import 'dart:math';

import 'package:balloonclicker/background_cahnger.dart';
import 'package:balloonclicker/balloon_changer.dart';
import 'package:balloonclicker/leaderboard.dart';
import 'package:balloonclicker/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balloon Clicker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Balloon Clicker'),
    );
  }
}

class Balloon {
  double xPos;
  double yPos;
  String color;
  int offset;

  Balloon(
      {required this.xPos,
      required this.yPos,
      required this.color,
      required this.offset});

  void letFloat(double amount) {
    yPos -= amount;
  }

  bool isAbove() {
    return yPos <= -100;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Balloon> balloons = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late SharedPreferences prefs;

  double clicks = 0;
  double multiplier = 1;
  bool enableBalloons = true;
  String balloonColor = "red";
  int background = 1;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    prefs = await SharedPreferences.getInstance();
    enableBalloons = prefs.getBool('enable_balloons') ?? true;
    balloonColor = prefs.getString('balloon_color') ?? "red";
    background = prefs.getInt('background') ?? 1;
    clicks = prefs.getDouble('score') ?? 0;
    setState(() {});
  }

  void newAdd(TapDownDetails details) {
    HapticFeedback.heavyImpact();
    clicks += multiplier;
    setState(() {});
    final List<String> myStrings = [
      "red",
      "green",
      "blue",
      "yellow",
      "pink",
      "sheep"
    ];
    final Random random = Random();
    final String randomString = myStrings[random.nextInt(myStrings.length)];
    balloons.add(Balloon(
        xPos: details.localPosition.dx - 18,
        yPos: details.localPosition.dy - 50,
        color: randomString,
        offset: random.nextInt(100)));
  }

  String getScoreString() {
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

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  double calculateBalloonX(double value, double offset, double constantOffset) {
    double amplitude = 5.0; // Maximum horizontal oscillation
    double frequency = 3; // Adjust this value for the speed of oscillation

    // Calculate the phase shift based on the offset and constantOffset
    double phaseShift = (offset / 100 + constantOffset / 5) * 2 * pi;

    // Calculate the horizontal position
    double x = amplitude * sin(2 * pi * frequency * value / 10 + phaseShift);

    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: _openDrawer,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            FloatingActionButton.extended(
              heroTag: 'balloon',
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BalloonChanger()));
                balloonColor = prefs.getString("balloon_color") ?? "red";
                setState(() {});
              },
              label: const Text("Balloon"),
            ),
            const Spacer(),
            FloatingActionButton.extended(
              heroTag: 'background',
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BackgroundCahnger()));
                background = prefs.getInt("background") ?? 1;
                setState(() {});
              },
              label: const Text("Background"),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background$background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GestureDetector(
            onTapDown: newAdd,
            child: Stack(
              children: [
                Positioned(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/score.png",
                            width: 100,
                          ),
                          Text(
                            getScoreString(),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/balloon_$balloonColor.png",
                    scale: 1.5,
                  ),
                ),
                LoopAnimationBuilder<double>(
                  builder: (context, value, _) {
                    List<Widget> stackItems = [];
                    List<Balloon> nb = List.from(balloons);
                    bool modified = false;
                    for (Balloon b in balloons) {
                      if (b.isAbove()) {
                        nb.remove(b);
                        modified = true;
                        continue;
                      }
                      b.letFloat(10);
                      b.xPos +=
                          calculateBalloonX(value, b.offset.toDouble(), 5);
                      stackItems.add(
                        Positioned(
                          top: b.yPos,
                          left: b.xPos,
                          child: Image.asset(
                            "assets/balloon_${b.color}.png",
                            height: 100,
                          ),
                        ),
                      );
                    }
                    if (modified) balloons = nb;
                    return Stack(
                      children: stackItems,
                    );
                  },
                  tween: Tween(begin: 0, end: 10),
                  duration: const Duration(milliseconds: 7500),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const ListTile(
              title: Text("Balloon Clicker"),
            ),
            const Divider(),
            ListTile(
              title: const Text("Leaderboard"),
              leading: const Icon(Icons.ballot),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Leaderboard()));
              },
            ),
            ListTile(
              title: const Text("Settings"),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
