import 'package:flutter/material.dart';

class DerivMarketText extends StatelessWidget {
  const DerivMarketText(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.textIcon})
      : super(key: key);

  final String text;
  final Color textColor;
  final IconData textIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w300, color: textColor),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        Icon(
          textIcon,
          color: textColor,
        )
      ],
    );
  }
}
