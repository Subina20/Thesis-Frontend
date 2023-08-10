import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/provider/userProvider.dart';

class AcneSeverity extends ConsumerStatefulWidget {
  const AcneSeverity({Key? key}) : super(key: key);

  @override
  _AcneSeverityState createState() => _AcneSeverityState();
}

class _AcneSeverityState extends ConsumerState<AcneSeverity> {
  double selectedAcneSeverity = 1.0; // Set an initial value

  @override
  void initState() {
    super.initState();
    // Check if the userProvider has a saved value for acneSeverity, and if yes, set it as the selected value
    final userInfo = ref.read(userProvider);
    if (userInfo.user!.acneSeverity != 0.0) {
      setSelectedAcneSeverity(userInfo.user!.acneSeverity);
    } else {
      setSelectedAcneSeverity(1.0);
    }
  }

  void setSelectedAcneSeverity(double value) {
    setState(() {
      selectedAcneSeverity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.read(userProvider);
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
                              'How severe is your acne on a scale of 1-10 (with 10 being the most severe)?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Slider(
                              value: selectedAcneSeverity,
                              onChanged: (value) {
                                // Update the selected value
                                setSelectedAcneSeverity(value);
                                userInfo.updateUser(
                                    acneSeverity: selectedAcneSeverity);
                              },

                              min: 1.0,
                              max: 10.0,
                              divisions: 9,
                              activeColor: Colors.pink[
                                  300], // Change the active color to green
                              inactiveColor: const Color.fromARGB(255, 0, 0, 0),
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
