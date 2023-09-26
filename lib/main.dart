import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

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
      home: const MyHomePage(title: 'Baloon Clicker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _idCounter = 0;
  final Set<int> _availableIds = {};
  final Map<int, PlayAnimationBuilder<double>> _buttons = {};
  final Map<int, PlayAnimationBuilder<double>> _balloons = {};

  double clicks = 0;
  double multiplier = 1;

  @override
  void initState() {
    super.initState();
  }

  void _addButton(TapDownDetails details) {
    setState(() {
      clicks += multiplier;
      int id;
      if (_availableIds.isNotEmpty) {
        id = _availableIds.first;
        _availableIds.remove(id);
      } else {
        id = _idCounter++;
      }
      _buttons[id] = PlayAnimationBuilder<double>(
        tween: Tween(begin: 10, end: 0),
        duration: const Duration(milliseconds: 750),
        builder: (context, value, _) {
          return Positioned(
            left: details.localPosition.dx - 13,
            top: details.localPosition.dy - 13 - (-value * 2),
            child: Opacity(
              opacity: value / 10,
              child: Text(
                "+${multiplier.toStringAsFixed(0)}",
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        },
        onCompleted: () {
          setState(() {
            _buttons.remove(id);
          });
        },
      );
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      double yposition = Random().nextInt(screenWidth.toInt()).toDouble();
      _balloons[id] = PlayAnimationBuilder<double>(
        tween: Tween(begin: screenHeight + 100, end: 0),
        duration: const Duration(milliseconds: 5000),
        builder: (context, value, _) {
          return Positioned(
            left: yposition,
            top: value - 100,
            child: Image.asset(
              "assets/balloon.png",
              height: 100,
            ),
          );
        },
        onCompleted: () {
          setState(() {
            _balloons.remove(id);
            _availableIds.add(id);
          });
        },
      );
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Balloon"),
            ),
            const Spacer(),
            FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Background"),
            ),
            const Spacer(),
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.question_mark),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 204, 204, 204),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GestureDetector(
            onTapDown: _addButton,
            child: Stack(
              children: [
                ..._balloons.values,
                Positioned(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/score.png",
                        width: 100,
                      ),
                      Text(getScoreString()),
                    ],
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/balloon.png",
                    scale: 1.5,
                  ),
                ),
                ..._buttons.values,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
