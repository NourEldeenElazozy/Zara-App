/*
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

class SingleCategoryScreen2 extends StatelessWidget
{
  final int id;
  final String title;
  var product;

  SingleCategoryScreen2(this.id, this.title);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di<SingleCategoryCubit>()..getCategories(id, context),
      child: BlocConsumer<SingleCategoryCubit, SingleCategoryStates>(
        listener: (context, state) {},
        builder: (context, state)
        {

          var model = SingleCategoryCubit.get(context).singleCategoryModel;
          var buffer = AppCubit.get(context).listProductsCat;
           var products=<ProductsCat>[];

          for(var index=1;index<10;index++){
            product = ProductsCat(name: 'pro $index');
            products.add(product);

          }
          products.forEach(( var value) =>print(value.name));

          print('SingleCategoryScreen');
          print(AppCubit.get(context).categoryId);
          print(AppCubit.get(context).categories);








          return Scaffold(
            appBar: AppBar(
              title: Text(
                title,
              ),
            ),
            body: ListView.builder(
            itemCount: products.length,
              itemBuilder: (context, index) {

                return  InkWell(
                  onTap: () {
                    //navigateTo(context, SingleCategoryScreen(),);
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
                                  'https://pictures-nigeria.jijistatic.com/67753683_MTA4MC0xMDgwLWVjY2NiZTIyMWEtMQ.jpg',
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

                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    bottom: 10.0,
                                  ),
                                  child: Container(
                                    child: Text(
                                        ('s'),
                                      style: white12regular(),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                    ),
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  's',
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
                                                    '5',
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

                                              Row(
                                                children: [
                                                  Text(
                                                    '2',
                                                    style: black12bold().copyWith(
                                                      color: Colors.grey,
                                                      decoration: TextDecoration.lineThrough,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 5.0,
                                                    ),
                                                    child: Container(
                                                      width: 1.0,
                                                      height: 10.0,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Text(
                                                    '2',
                                                    style: black12bold().copyWith(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        */
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
                              ),*//*

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
        }
          ));
        },
      ),
    );
  }

  Widget singleProductItem({
    @required Products model,
    @required BuildContext context,
    @required int index,
  }) =>
      InkWell(
        onTap: () {
          //navigateTo(context, SingleCategoryScreen(),);
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
                        'https://pictures-nigeria.jijistatic.com/67753683_MTA4MC0xMDgwLWVjY2NiZTIyMWEtMQ.jpg',
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

                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          bottom: 10.0,
                        ),
                        child: Container(
                          child: Text(
                            'buffer.name',
                            style: white12regular(),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        's',
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
                                          '5',
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

                                    Row(
                                      children: [
                                        Text(
                                          '2',
                                          style: black12bold().copyWith(
                                            color: Colors.grey,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0,
                                          ),
                                          child: Container(
                                            width: 1.0,
                                            height: 10.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '2',
                                          style: black12bold().copyWith(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                    ),
                                  ],
                                ),
                              ),
                              */
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
                              ),*//*

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
}
class ProductsCat{
  String name;
  ProductsCat({this.name});
}

*/
