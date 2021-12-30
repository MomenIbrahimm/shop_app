import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local.dart';

class OnBoardingModel {
  final String image;
  final String title1;
  final String title2;
  final String title3;

  OnBoardingModel(
      {required this.title1,
      required this.title2,
      required this.title3,
      required this.image});
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      title1: 'Explore many products',
      title2: 'Lorem ipsum dolor sit amet,',
      title3: 'Consectetur adipiscing elit',
      image: 'assets/onBoard1.jpg'),
  OnBoardingModel(
      title1: 'Choose and checkout',
      title2: 'Lorem ipsum dolor sit amet,',
      title3: 'Consectetur adipiscing elit',
      image: 'assets/image2.jpg'),
  OnBoardingModel(
      title1: 'Get it delivered',
      title2: 'Lorem ipsum dolor sit amet,',
      title3: 'Consectetur adipiscing elit',
      image: 'assets/onBoard3.jpg'),
];

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              boardController.jumpToPage(boardController.initialPage);
            },
            icon: const Icon(IconlyLight.arrowLeft2),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == onBoardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => boardingBuildItem(index),
                itemCount: onBoardingList.length,
              ),
            ),
          ],
        ));
  }

  Widget boardingBuildItem(index) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                      child: Image(
                    image: AssetImage(onBoardingList[index].image),
                    height: 150,
                    width: double.infinity,
                        fit: BoxFit.cover,
                  )),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  onBoardingList[index].title1,
                  style: TextStyle(
                      fontSize: 22.5,
                      color: HexColor('1597E5'),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(onBoardingList[index].title2),
                const SizedBox(
                  height: 20,
                ),
                Text(onBoardingList[index].title3),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: Column(
              children: [
                defaultButton(
                    text: 'Next',
                    function: () {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.fastOutSlowIn);
                      if (isLast) {
                        submit();
                      }
                    }),
                defaultTextButton(
                    text: 'Skip',
                    size: 14,
                    function: () {
                      submit();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
