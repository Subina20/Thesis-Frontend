import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/firebase_options.dart';
import 'package:skincare_recommendation/screens/survey_screen.dart';
import 'package:skincare_recommendation/screens/testing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: SkinCareRecommendation()));
}

class SkinCareRecommendation extends StatelessWidget {
  const SkinCareRecommendation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Skin Care Recommendation"),
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/SurveyScreen',
      routes: {
        '/SurveyScreen': (context) => const SurveyScreen(),
        '/FinalResult': (context) => const FinalResult(),

        // '/IntroScreen': (context) => const IntroScreen(),
        // '/NameScreen': (context) => const NameScreen(),
        // '/GenderScreen': (context) => const GenderScreen(),
        // '/OccupationScreen': (context) => const OccupationScreen(),
        // '/LocationScreen': (context) => const LocationScreen(),
        // '/FindScreen': (context) => const FindScreen(),
        // '/FirstScreen': (context) => const FirstScreen(),
        // '/SecondScreen': (context) => const SecondScreen(),
      },
    );
  }
}
