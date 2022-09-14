import 'package:flutter/material.dart';
import 'package:mealapp/modules/login/log%20in.dart';
import 'package:mealapp/shared/components/components/components.dart';
import 'package:mealapp/shared/network/cachehelper.dart';
import 'package:mealapp/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/constant/constant.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                //move to login
                submitBoarding(context: context);
              },
              child: const Text("SKIP"),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: indicatorController,
                  itemBuilder: (context, index) =>
                      buildOnBoard(buildPageView[index]),
                  itemCount: buildPageView.length,
                  onPageChanged: (index) {
                    if (index < buildPageView.length - 1) {
                      isEnd = false;
                    } else {
                      isEnd = true;
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: indicatorController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          activeDotColor: defaultColor,
                          dotWidth: 10.0,
                          dotHeight: 10.0,
                          expansionFactor: 4)),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isEnd) {
                        submitBoarding(context: context);
                      } else {
                        indicatorController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios_outlined),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
