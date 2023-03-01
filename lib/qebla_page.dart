import 'package:flutter/material.dart';


class QeblaPage extends StatefulWidget {
  const QeblaPage({super.key});

  @override
  State<QeblaPage> createState() => _QeblaPageState();
}

class _QeblaPageState extends State<QeblaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اتجاه القبلة'),
      centerTitle: true,
      ),
      body: null,
    );
  }
}