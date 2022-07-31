import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/home/home_model.dart';
import 'package:salla/modules/single_category/cubit/cubit.dart';
import 'package:salla/modules/single_category/cubit/states.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

class CartScreen extends StatelessWidget {

  myProductCart my;

  CartScreen();

  @override
  Widget build(BuildContext context) {

    var model = AppCubit.get(context).productsCart;
    var getCartItems = AppCubit.get(context).productsId;
    AppCubit.get(context).getCategoriesItems();
    print('categoryIdd');
    print(getCartItems);

    return Scaffold(

        body: ListView.separated(
          itemCount: model.length,
          separatorBuilder: (BuildContext context,
              int index) => const Divider(),
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                print('items');
                print(getCartItems);
                AppCubit.get(context).getDeleteItems(getCartItems);
                print(AppCubit.get(context).getDeleteItems(getCartItems));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 130.0,
                  child: Row(
                    children: [
                      Container(
                        height: 130.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            2.0,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              'http://abdudashapi-001-site1.htempurl.com/img/${model[index].imageUrl}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [

                            Text(
                              model[index].name,
                              maxLines: 2,
                              style: TextStyle(
                                height: 1.4,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Spacer(),
                            BlocConsumer<AppCubit, AppStates>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children:
                                        [
                                          Row(
                                            children: [
                                              Text(
                                                '${model[index].Price.round()}',
                                                style: black16bold().copyWith(
                                                  height: .5,
                                                  color: defaultColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                appLang(context).currency,
                                                style: black12bold().copyWith(
                                                  height: .5,
                                                  color: defaultColor,
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    /*FloatingActionButton(
                                onPressed: ()
                                {
                                  AppCubit.get(context).changeFav(
                                    id: model.id,
                                  );
                                },
                                heroTag : '2',
                                backgroundColor:
                                AppCubit.get(context).favourites[model.id]
                                    ? Colors.green
                                    : null,
                                mini: true,
                                child: Icon(
                                  IconBroken.Heart,
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  AppCubit.get(context).changeCart(
                                    id: model.id,
                                  );
                                },
                                heroTag : '1',
                                backgroundColor: AppCubit.get(context).cart[model.id]
                                    ? Colors.green
                                    : null,
                                mini: true,
                                child: Icon(
                                  IconBroken.Buy,
                                ),
                              ),*/
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },

        )
    );
  }

}