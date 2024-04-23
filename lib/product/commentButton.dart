import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentButton extends StatelessWidget {
  final void Function()? onTap;

  const CommentButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        FontAwesomeIcons.comment,
        color: Colors.grey,
      ),
    );
  }
}
