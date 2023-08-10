import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/provider/userProvider.dart'; // Import userProvider and UserProvider class

class GenderScreen extends ConsumerStatefulWidget {
  const GenderScreen({Key? key}) : super(key: key);

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends ConsumerState<GenderScreen> {
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    // Fetch the gender from the provider and set the selectedGender accordingly
    final userInfo = ref.read(userProvider).user;
    if (userInfo != null && userInfo.gender.isNotEmpty) {
      selectedGender = userInfo.gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: const [],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          const Text(
                            'Nice To Meet You',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            'What\'s Your Gender ?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedGender == 'Male'
                                    ? Colors
                                        .green // Change to green if selectedGender is 'Male'
                                    : Colors.pink[300],
                              ),
                              onPressed: () {
                                // Update the selected gender and the userProvider
                                setState(() {
                                  selectedGender = 'Male';
                                });
                                ref
                                    .read(userProvider)
                                    .updateUser(gender: 'Male');
                              },
                              child: const Text('Male'),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedGender == 'Female'
                                    ? Colors
                                        .green // Change to green if selectedGender is 'Female'
                                    : Colors.pink[300],
                              ),
                              onPressed: () {
                                // Update the selected gender and the userProvider
                                setState(() {
                                  selectedGender = 'Female';
                                });
                                ref
                                    .read(userProvider)
                                    .updateUser(gender: 'Female');
                              },
                              child: const Text('Female'),
                            ),
                          ),
                        ],
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
