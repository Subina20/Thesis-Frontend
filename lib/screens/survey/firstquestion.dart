import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/provider/userProvider.dart';

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {
  String? selectedSkinType;

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userProvider);

    // Check if the user's skin type is already in the provider, and update selectedSkinType accordingly
    if (userInfo.user?.skinType != null && userInfo.user!.skinType.isNotEmpty) {
      selectedSkinType = userInfo.user!.skinType;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'What is your Skin Type ?',
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
                                  backgroundColor: selectedSkinType ==
                                          'combination'
                                      ? Colors
                                          .green // Change to green if selectedSkinType is 'Combination'
                                      : Colors.pink[300],
                                ),
                                onPressed: () {
                                  // Update the selected skin type and the userProvider
                                  setState(() {
                                    selectedSkinType = 'combination';
                                  });
                                  ref
                                      .read(userProvider)
                                      .updateUser(skinType: 'combination');
                                },
                                child: const Text('Combination'),
                              ),
                            ),
                            // Repeat the same for other skin types (Oily, Dry, Sensitive)
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedSkinType == 'oily'
                                      ? Colors
                                          .green // Change to green if selectedSkinType is 'Oily'
                                      : Colors.pink[300],
                                ),
                                onPressed: () {
                                  // Update the selected skin type and the userProvider
                                  setState(() {
                                    selectedSkinType = 'oily';
                                  });
                                  ref
                                      .read(userProvider)
                                      .updateUser(skinType: 'oily');
                                },
                                child: const Text('Oily'),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedSkinType == 'dry'
                                      ? Colors
                                          .green // Change to green if selectedSkinType is 'Dry'
                                      : Colors.pink[300],
                                ),
                                onPressed: () {
                                  // Update the selected skin type and the userProvider
                                  setState(() {
                                    selectedSkinType = 'dry';
                                  });
                                  ref
                                      .read(userProvider)
                                      .updateUser(skinType: 'dry');
                                },
                                child: const Text('Dry'),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedSkinType ==
                                          'sensitive'
                                      ? Colors
                                          .green // Change to green if selectedSkinType is 'Sensitive'
                                      : Colors.pink[300],
                                ),
                                onPressed: () {
                                  // Update the selected skin type and the userProvider
                                  setState(() {
                                    selectedSkinType = 'sensitive';
                                  });
                                  ref
                                      .read(userProvider)
                                      .updateUser(skinType: 'sensitive');
                                },
                                child: const Text('Sensitive'),
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
        ),
      ),
    );
  }
}
