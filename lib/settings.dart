import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool musicOn = true;
  bool soundOn = true;
  bool hapticOn = true;

  double musicVol = 1;
  double soundVol = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: "music",
                    onPressed: () {
                      setState(() {
                        musicOn = !musicOn;
                        musicVol = musicOn ? 1 : 0;
                      });
                    },
                    child: Icon(musicOn ? Icons.music_note : Icons.music_off),
                  ),
                  Slider(
                    value: musicVol,
                    onChanged: (val) {
                      setState(() {
                        musicVol = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  FloatingActionButton(
                    heroTag: "sounds",
                    onPressed: () {
                      setState(() {
                        soundOn = !soundOn;
                        soundVol = soundOn ? 1 : 0;
                      });
                    },
                    child: Icon(soundOn ? Icons.volume_up : Icons.volume_off),
                  ),
                  Slider(
                    value: soundVol,
                    onChanged: (val) {
                      setState(() {
                        soundVol = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  FloatingActionButton.extended(
                    heroTag: "haptic",
                    onPressed: () {
                      setState(() {
                        hapticOn = !hapticOn;
                      });
                    },
                    icon: Icon(hapticOn ? Icons.vibration : Icons.mobile_off),
                    label: hapticOn
                        ? const Text("Haptic feedback on")
                        : const Text("Haptic feedback off"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
