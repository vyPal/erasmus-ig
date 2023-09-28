import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackgroundCahnger extends StatefulWidget {
  const BackgroundCahnger({Key? key}) : super(key: key);

  @override
  State<BackgroundCahnger> createState() => _BackgroundCahngerState();
}

class _BackgroundCahngerState extends State<BackgroundCahnger> {
  int _selectedBackground = 1;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  void asyncInit() async {
    prefs = await SharedPreferences.getInstance();
    _selectedBackground = prefs.getInt("background") ?? 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? l = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final balloonHeight = screenHeight * 0.6;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l!.selectBackground),
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
                  "assets/background$_selectedBackground.png",
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                final color = [1, 2, 3, 4][index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBackground = color;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/background$color.png",
                      width: 100,
                      height: 100,
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              prefs.setInt("background", _selectedBackground);
              Navigator.pop(context);
            },
            child: Text(l.equipBackground),
          ),
        ],
      ),
    );
  }
}
