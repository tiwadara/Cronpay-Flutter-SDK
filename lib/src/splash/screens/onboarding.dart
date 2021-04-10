import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/asset_constants.dart';
import 'package:cron_pay/src/splash/models/walkthrough.dart';
import 'package:cron_pay/src/splash/widget/slide_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Onboarding extends StatefulWidget {
  static const String routeName = '/Onboarding';
  final List<WalkThrough> pages = [
    WalkThrough(
      image: Assets.slide_one,
      title: "Easy Payment Scheduler",
      subtitle: "Do df df dipmd",
      description:
          "Maecenas at maximus dolor. Fusce bibendum \npretium semper. Donec rhoncus tellus vitae dolor \nconsectetur laoreet.",
    ),
    WalkThrough(
      image: Assets.slide_two,
      title: "Transaction History",
      subtitle: "lorem dem iptd y",
      description:
          "Maecenas at maximus dolor. Fusce bibendum \npretium semper. Donec rhoncus tellus vitae dolor \nconsectetur laoreet.",
    ),
    WalkThrough(
      image: Assets.slide_three,
      title: "Lorem",
      subtitle: "Your digital business associate",
      description: "Stay on top of your business \nnumbers at a glance.",
    ),
  ];

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<Onboarding> {
  SwiperController swiperController = SwiperController();
  ValueNotifier<int>  indexCountOnSwipe = ValueNotifier(0);



  @override
  Widget build(BuildContext context) {
    final Function hp = Screen(MediaQuery.of(context).size).hp;
    final Function wp = Screen(MediaQuery.of(context).size).wp;
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Swiper.children(
                autoplay: false,
                index: 0,
                loop: false,
                children: _getPages(hp, wp),
                controller: swiperController,
                pagination: new SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                  swiperController.config = config;
                  return Container();
                }),
                onIndexChanged: (value) {
                   indexCountOnSwipe.value = value;
                },
              ),
            ),
            Column(
              children: [
                SlideProgressWidget(swiperController: swiperController, pages: widget.pages, indexCountOnSwipe: indexCountOnSwipe),
                SizedBox(
                  height: 45.h,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _getPages(Function hp, Function wp) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.pages.length; i++) {
      WalkThrough page = widget.pages[i];
      widgets.add(slide(hp, wp, page: page));
    }

    return widgets;
  }
}

Widget slide(Function hp, Function wp, {WalkThrough page}) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Column(
      children: <Widget>[
        SizedBox(height: 50.h),
        SizedBox(
          height: 260.h,
          child: Image(
            image: AssetImage(page.image),
          ),
        ),
        Text(
          page.title,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 21.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(5),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        SizedBox(
          height: 90.h,
          child: Text(
            page.description,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        // SizedBox(height: 41.h,)
      ],
    ),
  );
}
