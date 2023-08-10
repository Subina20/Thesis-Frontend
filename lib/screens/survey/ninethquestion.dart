import 'package:flutter/material.dart';

class NinthScreen extends StatelessWidget {
  const NinthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: const [],
            ),
          ),
          Container(
            child: Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                // decoration: const BoxDecoration(color: Colors.red),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.blue,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'Are you willing to make changes to your current skin care routine to address your acne?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink[300],
                              ),
                              onPressed: () {},
                              child: const Text('yes ')),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink[300],
                              ),
                              onPressed: () {},
                              child: const Text('No'),
                              ),
                         
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Do something when the button is pressed
                            },
                            icon: const Icon(Icons.skip_previous),
                            label: const Text('Previous'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink[300],
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Do something when the button is pressed
                            },
                            icon: const Icon(Icons.next_plan),
                            label: const Text('Next'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
