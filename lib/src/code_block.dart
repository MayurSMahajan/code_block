import 'package:flutter/material.dart';

class CodeBlock extends StatefulWidget {
  const CodeBlock({super.key});

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.grey.withOpacity(0.1),
      ),
      width: MediaQuery.of(context).size.width,
      child: const Placeholder(),
    );
  }
}
