import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../core/colors.dart';

class CountIndicator extends StatelessWidget {
  const CountIndicator({
    super.key,
    required PageController controller,
    required this.count,
  }) : _controller = controller;

  final PageController _controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: count > 0
          ? SmoothPageIndicator(
        controller: _controller,
        count: count,
        effect: SwapEffect(
          activeDotColor: ColorConstants.instance.activatedButton,
          dotColor: Colors.deepPurple.shade100,
          dotHeight: 10.0,
          dotWidth: 10.0,
          spacing: 15.0,
        ),
      )
          : const SizedBox.shrink(), // Eğer count 0 ise göstergeleri göstermemek için
    );
  }
}