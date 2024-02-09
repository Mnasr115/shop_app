import 'package:flutter/material.dart';
import 'package:shop_app/modules/Auth/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/network/local/Cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String title, subTitle, image;

  BoardingModel({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();
  bool isLast = false;
  List<BoardingModel> boardingModel = [
    BoardingModel(
      title: 'Purchase Online !!',
      subTitle:
          "The customer is very important, the customer will follow but I give the same time as labor",
      image: 'assets/images/on_boarding_1.png',
    ),
    BoardingModel(
      title: 'Track order !!',
      subTitle:
          "The customer is very important, the customer will follow but I give the same time as labor",
      image: 'assets/images/on_boarding_2.png',
    ),
    BoardingModel(
      title: 'Get your order !!',
      subTitle:
          "The customer is very important, the customer will follow but I give the same time as labor",
      image: 'assets/images/on_boarding_3.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                'SKIP',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardingController,
                  onPageChanged: (int index) {
                    if (index == boardingModel.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boardingModel[index]),
                  itemCount: boardingModel.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: boardingController,
                    count: boardingModel.length,
                    axisDirection: Axis.horizontal,
                    effect: const ExpandingDotsEffect(
                        spacing: 5.0,
                        dotWidth: 10.0,
                        dotHeight: 10.0,
                        expansionFactor: 4,
                        dotColor: Colors.grey,
                        activeDotColor: kPrimaryColor),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: FloatingActionButton(
                      backgroundColor: kPrimaryColor,
                      onPressed: () {
                        if (isLast) {
                          submit();
                        } else {
                          boardingController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value!) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false);
      }
    });
  }

  Widget buildBoardingItem(BoardingModel boardingModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(boardingModel.image),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          boardingModel.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Janna',
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          boardingModel.subTitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
