import 'package:braga8_tenant_app/views/onboarding/onboarding_screen.dart';
import 'package:braga8_tenant_app/widgets/main_layouts.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _opacity = 1.0;
        });
      }
    });

    Timer(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(
        child: Stack(
          children: [
            Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(milliseconds: 1500),
                curve: Curves.easeIn,
                child: SizedBox(
                  width: 90,
                  child: Image.asset('../../../assets/logo.png', fit: BoxFit.contain),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
