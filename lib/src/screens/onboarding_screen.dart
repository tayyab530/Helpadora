import 'package:flutter/material.dart';
import 'package:helpadora/src/notifiers/theme_data.dart';
import 'package:helpadora/src/screens/login_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  final List<PageViewModel> _pages = [
    PageViewModel(
      title: "Let's help together",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Image.asset('assets/images/MainImage.jpg'),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(color: Colors.orange),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
    PageViewModel(
      title: "We are a society here",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Image.network(
          'https://png.pngtree.com/png-clipart/20200701/original/pngtree-vector-community-service-png-image_5411974.jpg'),
      footer: ElevatedButton(
        onPressed: () {
          // On button presed
        },
        child: const Text("Let's Go !"),
      ),
    ),
    PageViewModel(
      title: "We are a society here",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Image.network(
          'https://png.pngtree.com/png-clipart/20200701/original/pngtree-vector-community-service-png-image_5411974.jpg'),
      footer: ElevatedButton(
        onPressed: () {
          // On button presed
        },
        child: const Text("Let's Go !"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _onboarding = Provider.of<ThemeNotifier>(context, listen: false);
    return IntroductionScreen(
      next: const Text('Next'),
      showSkipButton: true,
      skip: const Text('Skip'),
      pages: _pages,
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        _onboarding.setShowOnboardingFalse();
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      },
    );
  }
}
