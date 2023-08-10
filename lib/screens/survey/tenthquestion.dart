import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/provider/userProvider.dart';

class TenthScreen extends ConsumerStatefulWidget {
  const TenthScreen({Key? key}) : super(key: key);

  @override
  _TenthScreenState createState() => _TenthScreenState();
}

class _TenthScreenState extends ConsumerState<TenthScreen> {
  String? selectedOpenToNewProducts;

  @override
  void initState() {
    super.initState();
    // Check if the userProvider has a saved value for openToNewProducts, and if yes, set it as the selected value
    final userInfo = ref.read(userProvider);
    if (userInfo.user != null && userInfo.user!.openToNewProducts.isNotEmpty) {
      selectedOpenToNewProducts = userInfo.user!.openToNewProducts;
    }
  }

  void setSelectedOpenToNewProducts(String value) {
    setState(() {
      selectedOpenToNewProducts = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                              'Are you open to trying new acne treatment products or methods?',
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
                                  backgroundColor: selectedOpenToNewProducts ==
                                          'Yes'
                                      ? Colors
                                          .green // Change to green if selectedOpenToNewProducts is 'Yes'
                                      : Colors.pink[300],
                                ),
                                onPressed: () {
                                  // Update the selected value and the userProvider
                                  setState(() {
                                    selectedOpenToNewProducts = 'Yes';
                                  });
                                  ref
                                      .read(userProvider)
                                      .updateUser(openToNewProducts: 'Yes');
                                },
                                child: const Text('Yes'),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedOpenToNewProducts ==
                                          'No'
                                      ? Colors
                                          .green // Change to green if selectedOpenToNewProducts is 'No'
                                      : Colors.pink[300],
                                ),
                                onPressed: () {
                                  // Update the selected value and the userProvider
                                  setState(() {
                                    selectedOpenToNewProducts = 'No';
                                  });
                                  ref
                                      .read(userProvider)
                                      .updateUser(openToNewProducts: 'No');
                                },
                                child: const Text('No'),
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
