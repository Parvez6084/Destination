import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  final String value;
  const RowWidget({
    Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child:  Text(value, style: const TextStyle(color: Colors.white30),),
    );
  }
}
