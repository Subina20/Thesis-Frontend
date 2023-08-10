import 'package:flutter/material.dart';

class FindScreen extends StatelessWidget {
  const FindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: const [
                    SizedBox(height: 45),
                    Text(
                      'That was a good place to live',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      ' How did you know about our Skin Care Recommendation System ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Text Here',
                        hintText: 'write in short',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
