import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Icon icon;
  final VoidCallback onClick;
  final double width;
  final double height;
  final EdgeInsets margin;

  const CustomIconButton(
      {Key? key,
        required this.onClick,
        required this.icon,
        this.height = 24,
        this.margin = EdgeInsets.zero,
        this.width = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onClick,
      child: Container(
        margin: margin,
        child: icon,
      ),
    );
  }
}
