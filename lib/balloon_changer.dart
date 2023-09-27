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
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                final color = ["red", "green", "blue", "yellow", "pink"][index];
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
