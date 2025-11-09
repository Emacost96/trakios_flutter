import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  const Modal({super.key, required this.child});

  final Widget child;

  static showModal(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Modal(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 18.0),
      height: MediaQuery.of(context).size.height * 0.50,
      child: child);
  }
}
