import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalloonChanger extends StatefulWidget {
  const BalloonChanger({Key? key}) : super(key: key);

  @override
  State<BalloonChanger> createState() => _BalloonChangerState();
}

class _BalloonChangerState extends State<BalloonChanger> {
  String _selectedColor = "red";
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    prefs = await SharedPreferences.getInstance();
    _selectedColor = prefs.getString("balloon_color") ?? "red";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final balloonHeight = screenHeight * 0.6;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Select balloon"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 0,
            child: SizedBox(
              height: balloonHeight,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  "assets/balloon_$_selectedColor.png",
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final color = [
                  "red",
                  "green",
                  "blue",
                  "yellow",
                  "pink",
                  "sheep",
                  "zakaria"
                ][index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = color;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/balloon_$color.png",
                      width: 100,
                      height: 100,
                      scale: _selectedColor == color ? 3 : 5,
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              prefs.setString("balloon_color", _selectedColor);
              Navigator.pop(context);
            },
            child: const Text("Equip"),
          ),
        ],
      ),
    );
  }
}
