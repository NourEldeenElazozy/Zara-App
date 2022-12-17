import 'package:flutter/material.dart';
import 'package:salla/layout/home_layout.dart';
import 'package:salla/modules/home/home_screen.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardModel
{
  final String image;
  final String title;
  final String body;

  BoardModel({this.image, this.title, this.body});
}

class OnBoardScreen extends StatefulWidget
{
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>
{
  List<BoardModel> list;

  @override
  void initState()
  {
    super.initState();

    list =
    [
      BoardModel(
        image: 'assets/images/logo.png',
        title: appLang(context).title1,
        body: appLang(context).body1,
      ),
      BoardModel(
        image: 'assets/images/logo.png',
        title: appLang(context).title2,
        body: appLang(context).body2,
      ),
      BoardModel(
        image: 'assets/images/logo.png',
        title: appLang(context).title3,
        body: appLang(context).body3,
      ),
    ];
  }

  var isLast = false;
  final controller = PageController();

  void submit()
  {
    navigateAndFinish(
      context,
      HomeLayout(),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Directionality(
      textDirection: AppCubit.get(context).appDirection,
      child: Scaffold(
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
            title: Center(
              child: Text('P I N K  - S H O P',style: TextStyle(
                fontSize: 24.0,
                color: Colors.pink,
              ),),
            ),
            backgroundColor: Color.fromRGBO(
            255, 255, 255, 1.0)),
        body: Column(
          children: <Widget>
          [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (i)
                  {
                    if (i == (list.length - 1) && !isLast)
                      setState(() => isLast = true);
                    else if (isLast) setState(() => isLast = false);
                  },
                  controller: controller,
                  itemCount: list.length,
                  itemBuilder: (ctx, i) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Image(
                          image: AssetImage(
                            list[i].image,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        list[i].title,
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        list[i].body,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SmoothPageIndicator(
                    controller: controller,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.white30,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: list.length,
                  ),
                  FloatingActionButton(

                    onPressed: ()
                    {
                      if (isLast)
                      {
                        submit();
                      } else
                        controller.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.pink,
                    ),
                    backgroundColor: Colors.white, //<-- SEE HERE
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}