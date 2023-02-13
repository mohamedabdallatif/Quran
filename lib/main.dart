
import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/home_page.dart';
 void main(List<String> args) {
  runApp(const QuranApp());
}

class QuranApp extends StatefulWidget {
  const QuranApp({super.key});

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{ 
      await readjson();
      await getSettings();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
return MaterialApp(
  debugShowCheckedModeBanner: false,
      title: 'Quran',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      home: const HomePage(),
      );
  }
}