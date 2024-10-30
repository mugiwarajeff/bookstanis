import 'package:flutter/material.dart';

class BookLoadingCard extends StatefulWidget {
  const BookLoadingCard({super.key});

  @override
  State<BookLoadingCard> createState() => _BookLoadingCardState();
}

class _BookLoadingCardState extends State<BookLoadingCard> {
  final Color minColor = const Color.fromARGB(134, 255, 255, 255);
  final Color maxColor = const Color.fromARGB(108, 158, 158, 158);
  final int milissecondsDuration = 700;
  Color currentColor = Colors.white;
  Future<void> changeColor() async {
    if (!mounted) {
      return;
    }

    currentColor = currentColor == minColor ? maxColor : minColor;
    setState(() {});
    await Future.delayed(Duration(milliseconds: milissecondsDuration));
    changeColor();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    changeColor();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: AnimatedContainer(
                duration: Duration(milliseconds: milissecondsDuration),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: currentColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
            child: AnimatedContainer(
              duration: Duration(milliseconds: milissecondsDuration),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: currentColor),
              height: 15,
              width: double.infinity,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 8),
            child: AnimatedContainer(
              duration: Duration(milliseconds: milissecondsDuration),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: currentColor),
              height: 25,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
