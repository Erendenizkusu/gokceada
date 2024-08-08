import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../core/colors.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required PageController controller,
    required this.list,
  }) : _controller = controller;

  final PageController _controller;
  final List list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SmoothPageIndicator(
        controller: _controller,
        count: list.length,
        effect: SwapEffect(
          activeDotColor: ColorConstants.instance.activatedButton,
          dotColor: Colors.deepPurple.shade100,
          dotHeight: 10.0,
          dotWidth: 10.0,
          spacing: 15.0,
        ),
      ),
    );
  }
}