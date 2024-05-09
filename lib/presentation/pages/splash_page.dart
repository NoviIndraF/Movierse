
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movierse/core/styles/colors.dart';
import 'package:movierse/core/styles/texts.dart';

import 'main_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      });
    });

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: bgDark,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Movie', style: titleText.copyWith(color: accentColor, fontSize: 28),),
                Text('rse', style: titleText.copyWith(color: whiteColor, fontSize: 28),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
