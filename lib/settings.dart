import 'package:balloonclicker/languages.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      prefs = await SharedPreferences.getInstance();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(l!.settings),
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
            Row(
              children: [
                FloatingActionButton(
                  heroTag: "music",
                  onPressed: () {
                    setState(() {
                      musicOn = !musicOn;
                      musicVol = musicOn ? 1 : 0;
                      prefs.setBool('musicon', musicOn);
                      prefs.setDouble('musicvol', musicVol);
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
            const SizedBox(height: 12),
            Row(
              children: [
                FloatingActionButton(
                  heroTag: "sound",
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
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    hapticOn = !hapticOn;
                  });
                },
                icon: Icon(hapticOn ? Icons.vibration : Icons.mobile_off),
                label: hapticOn
                    ? Text(l.hapticFeedbackOn)
                    : Text(l.hapticFeedbackOff),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Languages()));
                },
                icon: const Icon(Icons.language),
                label: Text(l.selectLanguage),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(LineIcons.discord),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(LineIcons.instagram),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(LineIcons.twitter),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(LineIcons.redditLogo),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(LineIcons.youtube),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(LineIcons.globe),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
