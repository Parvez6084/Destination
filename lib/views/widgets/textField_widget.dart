import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final List<TextInputFormatter>? textFormat;

  const TextFieldWidget({
    Key? key,
    this.textFormat,
    required this.controller,
    required this.keyboardType,
    required this.onChanged,
    required this.label,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            validator: (value) => value!.isEmpty ? 'This field is required' : null,
            decoration: const InputDecoration(
                fillColor: Colors.white10,
                filled: true,
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(8)))),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
