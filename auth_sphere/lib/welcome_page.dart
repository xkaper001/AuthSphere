import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final PageController pageController;
  const WelcomePage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome to AuthSphere',
            style: TextStyle(color: Colors.white, fontSize: 36),
          ),
            const SizedBox(height: 48,),
          FilledButton(
            onPressed: () => pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            ),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            child: const Text(
              "Start",
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          )
        ],
      ),
    );
  }
}
