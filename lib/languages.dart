import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages extends StatefulWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class LocaleOption {
  final String name;
  final String code;
  final Flag flag;

  LocaleOption({required this.name, required this.code, required this.flag});
}

class _LanguagesState extends State<Languages> {
  List<LocaleOption> opts = [
    LocaleOption(
      name: 'english',
      code: 'en',
      flag: Flag.fromCode(FlagsCode.GB, height: 50),
    ),
    LocaleOption(
      name: 'español',
      code: 'es',
      flag: Flag.fromCode(FlagsCode.ES, height: 50),
    ),
    LocaleOption(
      name: 'français',
      code: 'fr',
      flag: Flag.fromCode(FlagsCode.FR, height: 50),
    ),
    LocaleOption(
      name: 'deutsch',
      code: 'de',
      flag: Flag.fromCode(FlagsCode.DE, height: 50),
    ),
    LocaleOption(
      name: 'čeština',
      code: 'cs',
      flag: Flag.fromCode(FlagsCode.CZ, height: 50),
    ),
    LocaleOption(
      name: 'عربي لبناني',
      code: 'lb',
      flag: Flag.fromCode(FlagsCode.LB, height: 50),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select language"),
      ),
      body: ListView.builder(
        itemCount: opts.length,
        itemBuilder: (context, index) {
          final option = opts[index];
          return GestureDetector(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('locale', option.code);
              // Restart the app
              await Future.delayed(Duration(milliseconds: 500));
              await Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
            child: Card(
              child: Row(
                children: [
                  SizedBox(
                    width: 67,
                    child: option.flag,
                  ),
                  Text(option.name)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
