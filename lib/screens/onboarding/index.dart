// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:urcoin/utils/colors.dart';
import 'package:urcoin/utils/image.uri.dart';
import 'package:urcoin/widgets/buttons/button.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: _pages,
              ),
            ),
            const SizedBox(height: 36.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            const SizedBox(height: 50.0),
            Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.center,
              child: CustomButton(
                icon: const Icon(
                  Icons.stacked_line_chart,
                  color: Colors.white,
                ),
                radius: 30.0,
                text: "Get Started",
                onPressed: () => Navigator.pushNamed(context, '/signin'),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage(
      image: image1,
      title: "Welcome to upay",
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    const OnboardingPage(
      image: image2,
      title: "Visit listed menu",
      description:
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    const OnboardingPage(
      image: image3,
      title: "Selected your perefernce",
      description:
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    ),
    const OnboardingPage(
      image: image4,
      title: "Place your order",
      description:
          'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    ),
  ];

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(
        i == _currentPage ? _buildIndicator(true) : _buildIndicator(false),
      );
    }
    return indicators;
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      height: isActive ? 15.0 : 8.0,
      width: isActive ? 15.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? primaryColor : lightColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 300.0,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
