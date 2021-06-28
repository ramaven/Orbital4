import 'package:flutter/material.dart';
import 'package:login_register_auth/ui/widgets/original_button.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(),
            // Image.asset(
            //   'assets/images/main_top.png',
            // ),
            Hero(
              tag: 'logoAnimation',
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OriginalButton(
                text: 'Get Started',
                color: Colors.lightBlue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushNamed('login');
                },
              ),
            ),
            // Image.asset(
            //   'assets/images/main_bottom.png',
            //   fit: BoxFit.cover,
            // ),
          ],
        ),
      ),
    );
  }
}
