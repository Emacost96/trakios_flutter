import 'package:flutter/material.dart';
import 'package:trakios/theme/text_styles.dart';
import 'package:trakios/theme/theme.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = AppColors.primary,
    this.textColor = Colors.white,
  });

  final Function() onPressed;
  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // qui cambi il border radius
        ),
        textStyle: AppTextStyles.button(context),
        minimumSize: Size(MediaQuery.of(context).size.width * 1, 60),
      ),
      child: Text(text),
    );
  }
}
