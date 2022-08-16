import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/search_screen.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';


//الصفحة الرئيسية التي ينطلق منها الابلكيشن بعد الMain
class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(userToken);
  AppCubit.get(context).getCartData();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit.get(context).getCartData();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
            title: Row(
              children: [
                Center(
                  child: Center(
                    child: Text(
                      'ZARA',
                      style: TextStyle(
                        color:
                            Color.fromRGBO(255, 255, 255, 0.9254901960784314),
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Center(
                      child: new IconButton(
                    icon: new Icon(Icons.search),
                    onPressed: () {

                      navigateTo(context, SearchScreen());
                    },
                  )),
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
          ),
          body: AppCubit.get(context)
              .bottomWidgets[AppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Color.fromRGBO(3, 64, 129, 1.0),
            onTap: (index) {
              AppCubit.get(context).changeBottomIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: AppCubit.get(context).currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                  color: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
                ),
                label: appLang(context).home,
                backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Category,
                  color: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
                ),
                label: appLang(context).categories,
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Icon(
                      IconBroken.Bag,
                      color: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
                    ),
                    /* if(state is! AppLoadingState && AppCubit.get(context).cartProductsNumber != 0)*/
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
                      ),
                      padding: EdgeInsets.all(
                        3.0,
                      ),
                      child: Text(


                                  '',
                        style: white10bold(),
                      ),
                    ),
                  ],
                ),
                label: appLang(context).cart,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                  color: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
                ),
                label: appLang(context).settings,
              ),
            ],
          ),
        );
      },
    );
  }
}
