import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '/screens/sign/signIn.dart';
import '/utils/routes.dart';
import '/utils/sharedpreference.dart';

class OnBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    void onSkip() {
      Sharedpreference.saveData(key: 'onBoarding', value: true).then((value) {
        if (value) navPushRemove(context, LoginScreen());
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => onSkip(),
            child: Text(
              'Skip',
              style: TextStyle(color: theme.accentColor, fontSize: 18),
            ),
          )
        ],
      ),
      body: IntroductionScreen(
        globalBackgroundColor: theme.scaffoldBackgroundColor,
        rawPages: List.generate(
          3,
          (index) => PageView(
            title: 'Professional\nDesign${index + 1}',
            svgPic: 'assets/onBoarding/onBoard${index + 1}.svg',
          ),
        ),
        next: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Next',
            style: TextStyle(
              color: theme.textTheme.headline6?.color,
              fontSize: 18,
            ),
          ),
        ),
        done: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: theme.accentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: Text(
            'Done',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        onDone: () => onSkip(),
        scrollPhysics: BouncingScrollPhysics(),
        dotsDecorator: DotsDecorator(
          activeColor: theme.accentColor,
          size: Size.square(10.0),
          activeSize: Size(20.0, 10.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    );
  }
}

class PageView extends StatelessWidget {
  PageView({
    this.title = 'assets/onBoarding/onBoard1.svg',
    this.svgPic = 'Professional\nDesign',
  });
  final String svgPic;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 60, 80),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(svgPic, width: 400),
              SizedBox(height: 40),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys.',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
