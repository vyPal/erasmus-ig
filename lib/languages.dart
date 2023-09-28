import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  String _selectedLocaleCode = '';

  List<LocaleOption> opts = [
    LocaleOption(
      name: 'english',
      code: 'en',
      flag: Flag.fromCode(
        FlagsCode.GB_ENG,
      ),
    ),
    LocaleOption(
      name: 'español',
      code: 'es',
      flag: Flag.fromCode(
        FlagsCode.ES,
      ),
    ),
    LocaleOption(
      name: 'deutsch',
      code: 'de',
      flag: Flag.fromCode(
        FlagsCode.DE,
      ),
    ),
    LocaleOption(
      name: 'čeština',
      code: 'cs',
      flag: Flag.fromCode(
        FlagsCode.CZ,
      ),
    ),
    LocaleOption(
      name: 'عربي لبناني',
      code: 'ar',
      flag: Flag.fromCode(
        FlagsCode.AR,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: ListView.builder(
        itemCount: opts.length,
        itemBuilder: (context, index) {
          final option = opts[index];
          return Card(
            child: ListTile(
              leading: option.flag,
              title: Text(option.name),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('locale', option.code);
                setState(() {
                  _selectedLocaleCode = option.code;
                });
                // Restart the app
                await Future.delayed(Duration(milliseconds: 500));
                await Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
