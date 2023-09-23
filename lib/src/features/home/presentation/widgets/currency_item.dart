import 'package:flutter/material.dart';

class CurrencyItem extends StatelessWidget {
  final String text;
  final bool isActive;

  const CurrencyItem({Key? key, required this.isActive, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _circle(isActive),
        const SizedBox(
          width: 30,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _circle(bool isActive) {
    return Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isActive ? Colors.deepPurple : null,
            border: Border.all(
                color: isActive ? Colors.deepPurple : Colors.black12,
                width: 2)));
  }
}
