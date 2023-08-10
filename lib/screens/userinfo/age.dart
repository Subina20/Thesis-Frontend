import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/provider/userProvider.dart';

class AgeScreen extends ConsumerStatefulWidget {
  const AgeScreen({Key? key}) : super(key: key);

  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends ConsumerState<AgeScreen> {
  String? age;
  String _calculateAge(DateTime selectedDate) {
    final now = DateTime.now();
    var age = now.year - selectedDate.year;
    if (now.month < selectedDate.month ||
        (now.month == selectedDate.month && now.day < selectedDate.day)) {
      age--;
    }
    return age.toString();
  }

  void _showDatePicker(BuildContext context) async {
    final currentDate = DateTime.now();
    final userProviderData = ref.read(userProvider).user;
    final initialDate = userProviderData?.age == null ||
            userProviderData?.age == 0
        ? currentDate
        : DateTime.now().subtract(Duration(days: 365 * userProviderData!.age));

    final DateTime? pickedDate = await showDatePicker(
      
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: currentDate,
    );

    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        age = _calculateAge(pickedDate);
        print(age);
      });

      ref.read(userProvider).updateUser(age: int.parse(age!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = ref.read(userProvider);

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
                flex: 3,
                child: Column(
                  children: [
                    const SizedBox(height: 45),
                    const Text(
                      'Sounds Good',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      ' When is your birthdate?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[300]),
                        onPressed: () => _showDatePicker(context),
                        child: Text(age == null
                            ? 'Select Birthdate'
                            : 'Change Birthdate'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      userInfo.user != null
                          ? 'Age: ${userInfo.user!.age}'
                          : 'NA',
                      style: const TextStyle(fontSize: 16),
                    )
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
