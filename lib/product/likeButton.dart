import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool initialLiked;
  final Future<void> Function(bool currentLikeStatus) onTap;

  LikeButton({super.key, required this.initialLiked, required this.onTap});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.initialLiked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await widget.onTap(isLiked);
        setState(() {
          isLiked = !isLiked;
        });
      },
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
      ),
    );
  }
}
