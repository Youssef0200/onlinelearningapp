import 'package:flutter_svg/flutter_svg.dart';

import 'onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: "Numerous free \ntrial courses",
      descriptions: "Free courses for you to \nfind your way to learning",
      image: "assets/Onboarding1.svg",
    ),
    OnboardingInfo(
      title: "Quick and easy \nlearning",
      descriptions:
          "Easy and fast learning at \nany time to help you \nimprove various skills",
      image: "assets/Onboarding2.svg",
    ),
    OnboardingInfo(
      title: "Create your own \nstudy plan",
      descriptions:
          "Study according to the \nstudy plan, make study \nmore motivated",
      image: "assets/Onboarding3.svg",
    ),
  ];
}
