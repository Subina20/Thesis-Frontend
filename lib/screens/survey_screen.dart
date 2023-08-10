import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skincare_recommendation/screens/survey/firstquestion.dart';
import 'package:skincare_recommendation/screens/survey/secondquestion.dart';
import 'package:skincare_recommendation/screens/survey/tenthquestion.dart';
import 'package:skincare_recommendation/screens/survey/thridquestion.dart';

import 'package:skincare_recommendation/screens/userinfo/gender.dart';
import 'package:skincare_recommendation/screens/userinfo/intropage.dart';
import 'package:skincare_recommendation/screens/userinfo/age.dart';

import 'package:skincare_recommendation/screens/userinfo/namepage.dart';

class SurveyScreen extends ConsumerStatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  _SurveyScreenState createState() => _SurveyScreenState();
}

class _SurveyScreenState extends ConsumerState<SurveyScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  // final GlobalKey<TextFieldState> _textFieldKey = GlobalKey<TextFieldState>();

  void updateCurrentPageIndex() {
    setState(() {
      // _currentPageIndex = index;
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                IntroScreen(onGetStarted: () => updateCurrentPageIndex()),
                const NameScreen(),
                const GenderScreen(),
                const AgeScreen(),
                // const OccupationScreen(),
                const FirstScreen(),
                const SecondScreen(),
                const TenthScreen(),
                const AcneSeverity(),
              ],
            ),
          ),
          Visibility(
            visible: _currentPageIndex > 0,
            child: Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                // color: Colors.grey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _currentPageIndex > 1
                          ? () {
                              _controller.previousPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: const Icon(Icons.skip_previous),
                      label: const Text('Previous'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[300],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _currentPageIndex < 7
                          ? () {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          : () {
                              Navigator.pushNamed(context, '/FinalResult');
                            },
                      icon: const Icon(Icons.next_plan),
                      label: Text(_currentPageIndex == 7 ? 'Submit' : 'Next'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentPageIndex == 7
                            ? Colors.green
                            : Colors.pink[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
