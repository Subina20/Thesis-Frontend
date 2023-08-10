import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  final VoidCallback onGetStarted; // added named parameter

  const IntroScreen({Key? key, required this.onGetStarted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Image(
                  image: NetworkImage(
                      'https://img.freepik.com/premium-vector/skincare-beauty-products-cartoon-composition-with-creams-moisturizing-lotions-swirling-around-applying-face-mask-girl-illustration_1284-61173.jpg?w=2000')),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Hello, I am BeautyBrain, your new personal assistant',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'I\'m here for you. My service is just a couple of questions away from you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: onGetStarted, // added onPressed
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Get Started'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
