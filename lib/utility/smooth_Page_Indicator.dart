import 'package:flutter/material.dart';

class MyCustomSmoothPageIndicator extends StatefulWidget {
  const MyCustomSmoothPageIndicator({
    super.key,
    required this.pageController,
    required this.count,
    this.activeColor,
    this.inActiveColor,
    this.pageScrollDuration,
  });
  final PageController pageController;
  final int count;
  final Color? activeColor;
  final Color? inActiveColor;
  final Duration? pageScrollDuration;

  @override
  State<MyCustomSmoothPageIndicator> createState() =>
      _MyCustomSmoothPageIndicatorState();
}

class _MyCustomSmoothPageIndicatorState
    extends State<MyCustomSmoothPageIndicator> {
  late int currentIndex = widget.pageController.initialPage;
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      final scrollIndex = widget.pageController.page?.toInt();
      if (scrollIndex != currentIndex) {
        //print(scrollIndex);
        setState(() {
          currentIndex = scrollIndex!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:
          //method 1:
          //[for (int i = 0; i < widget.count; i++) customPageIndicator()]
          //method 2:
          List.generate(
        widget.count,
        (index) => customPageIndicator(
            //isSelected: index == currentIndex,
            activeColor: widget.activeColor,
            inActiveColor: widget.inActiveColor,
            index: index),
      ),
    );
  }

  InkWell customPageIndicator({
    double height = 7,
    double width = 17,
    Color? inActiveColor,
    Color? activeColor,
    required int index,
  }) =>
      InkWell(
        onTap: () {
          widget.pageController.animateToPage(index,
              duration: widget.pageScrollDuration ??
                  const Duration(milliseconds: 300),
              curve: Curves.linear);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          height: height,
          width: (index == currentIndex ? 1.4 : 1) * width,
          decoration: BoxDecoration(
            color: index == currentIndex
                ? activeColor ?? Colors.black
                : inActiveColor ?? Colors.grey,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      );
}
