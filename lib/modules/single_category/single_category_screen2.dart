import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/home/home_model.dart';
import 'package:salla/modules/single_category/cubit/cubit.dart';
import 'package:salla/modules/single_category/cubit/states.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

import '../item_screen.dart';

class SingleCategoryScreen2 extends StatelessWidget {
  final int id;
  final String title;
  myProduct my;

  SingleCategoryScreen2({this.id, this.title});

  @override
  Widget build(BuildContext context) {

    var model = AppCubit.get(context).products;
    var getCategoriesItems = AppCubit.get(context).categoryId;
    AppCubit.get(context).getCategoriesItems();
    print('categoryIdd');
    print(getCategoriesItems);

    return Scaffold(
        appBar: AppBar(backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
          title: Text(
            title,
          ),
        ),
        body: ListView.separated(
          itemCount: model.length,
          separatorBuilder: (BuildContext context,
              int index) => const Divider(),
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(

              onTap: () {

                navigateTo(context, ItemDetails(model[index].ProductId,model[index].name,model[index].imageUrl,model[index].description,[],0,model[index].price),);
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
                                'http://secondapi22-001-site1.atempurl.com/img/${model[index].imageUrl}',
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
                                                '${model[index].price.round()}',
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