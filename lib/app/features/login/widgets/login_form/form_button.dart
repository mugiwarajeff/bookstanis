import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final double buttonWidth;
  final double buttonHeight;
  final String labelText;
  final double fontSize;
  final Widget buttonIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function() onTap;

  const FormButton(
      {super.key,
      required this.buttonHeight,
      required this.buttonWidth,
      required this.fontSize,
      required this.labelText,
      required this.buttonIcon,
      this.textColor,
      this.backgroundColor,
      required this.onTap})
      : assert(buttonIcon is Icon || buttonIcon is Image);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(backgroundColor)),
            onPressed: onTap,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: buttonIcon,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    labelText,
                    style: TextStyle(fontSize: fontSize, color: textColor),
                  ),
                ),
              ],
            )));
  }
}
