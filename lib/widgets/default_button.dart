import 'package:flutter/material.dart';

class SpecialButton extends StatelessWidget {
  final Color bColor;
  final Color oLayColor;
  final Color tColor;
  final String text;
  final Function press;
  final IconData? icon;
  const SpecialButton({
    Key? key,
    required this.bColor,
    required this.tColor,
    required this.text,
    required this.press,
    required this.oLayColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 20,horizontal: 40)),
                  backgroundColor: MaterialStateProperty.resolveWith((states) => bColor),
                  overlayColor: MaterialStateProperty.resolveWith((states) => oLayColor)
              ),
              onPressed: () {
                press();
              },
              child: Text(
                text,
                style: TextStyle(color: tColor),)
          )
      ),
    );
  }
}