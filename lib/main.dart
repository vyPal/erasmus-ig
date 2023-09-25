import 'dart:async';

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
      title: 'Flutter Demo',
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
      home: const MyHomePage(title: 'Maybe I should put something here'),
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
  Set<int> _availableIds = Set();
  Map<int, PlayAnimationBuilder<double>> _buttons = {};

  void _addButton(TapDownDetails details) {
    setState(() {
      int id;
      if (_availableIds.isNotEmpty) {
        id = _availableIds.first;
        _availableIds.remove(id);
      } else {
        id = _idCounter++;
      }
      _buttons[id] = PlayAnimationBuilder<double>(
        key: ValueKey(id),
        tween: Tween(begin: 10, end: 0),
        duration: Duration(milliseconds: 750),
        builder: (context, value, _) {
          return Positioned(
            left: details.localPosition.dx - 13,
            top: details.localPosition.dy - 13 - (-value * 2),
            child: Image.asset(
              "assets/x1multiplier.png",
              width: 26,
              opacity: AlwaysStoppedAnimation(value / 10),
            ),
          );
        },
        onCompleted: () {
          setState(() {
            _buttons.remove(id);
            _availableIds.add(id);
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: GestureDetector(
          onTapDown: _addButton,
          child: Stack(
            children: [
              Center(
                child: Image.asset("assets/balloon.png"),
              ),
              ..._buttons.values,
            ],
          ),
        ),
      ),
    );
  }
}
