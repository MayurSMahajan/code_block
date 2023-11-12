import 'package:example/pages/editor_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Codeblock Example'),
      ),
      body: const EditorPage(),
    );
  }
}
