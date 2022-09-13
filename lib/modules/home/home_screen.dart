import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/categories/categories.dart';
import 'package:salla/models/categories/categories2.dart';
import 'package:salla/models/home/home_model.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/modules/single_category/single_category_screen.dart';
import 'package:salla/modules/single_category/single_category_screen2.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../item_screen.dart';

class HomeScreen extends StatelessWidget {
  String productsName='T';


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).homeModel;

        var categories = AppCubit.get(context).categoriesModel2;
        var productsName = AppCubit.get(context).searchData(this.productsName);






        return ConditionalBuilder(

          condition: model != null && categories != null ,

          builder: (context) => SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        appLang(context).browse,
                        style: black20bold(),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 110,
                  padding: EdgeInsets.all(
                    10.0,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        categoryItem(categories.categories[index], context),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.0,
                    ),
                    itemCount:categories.categories.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 10.0,
                  ),
                  child: Text(
                    appLang(context).new_arrivals,
                    style: black20bold(),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
                Container(
                  color: Colors.grey[300],
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 1 / 1.8,
                    children: List.generate(
                      model.products.length,
                          (index) => productGridItem(
                        model: model.products[index],
                        context: context,
                        index: index,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget categoryItem(Categories model, context  ) => InkWell(
    onTap: (){
      AppCubit.get(context).categoryId=model.id;
      AppCubit.get(context).getCategoriesItems();




      navigateTo(context, SingleCategoryScreen2(title: model.name),);
    },
    child: Container(
      width: 90.0,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
                'http://secondapi22-001-site1.atempurl.com/img/${model.imageUrl}',
            ),
            fit: BoxFit.cover,
            height: 90.0,
            width: 90.0,
          ),
          Container(
            width: double.infinity,
            height: 25.0,
            color: Colors.black.withOpacity(
              .8,
            ),
            child: Center(
              child: Text(
                model.name,
                style: white12bold(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget productGridItem({

    @required Products model,
    @required BuildContext context,
    @required int index,
  }) =>
      InkWell(

        onTap: (){


         int Listlength= model.images.length;
         List images=[];
         if (Listlength==0)
         {
           images = [];
         }
         if (Listlength==1)
           {
              images = <String>[model.images[0].imageUrl];
           }
         if(Listlength==2)
             {
                images = <String>[model.images[0].imageUrl,model.images[1].imageUrl];
             }
         if(Listlength==3)
         {
            images = <String>[model.images[0].imageUrl,model.images[1].imageUrl,model.images[2].imageUrl];
         }
         if(Listlength>=4)
         {
            images = <String>[model.images[0].imageUrl,model.images[1].imageUrl,model.images[2].imageUrl,model.images[3].imageUrl];
         }
          navigateTo(context, ItemDetails(model.id,model.name,model.imageUrl,model.description,images,Listlength,model.price),);
        },
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Center(
                      child: Image(
                        image: NetworkImage(

                          'http://secondapi22-001-site1.atempurl.com/img/${model.imageUrl}',
                        ),
                        //fit: BoxFit.cover,
                        height: 250.0,
                      ),
                    ),
                /*    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: AlignmentDirectional.bottomStart,
                       *//* child: Column(
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                AppCubit.get(context).changeFav(
                                  id: model.id,
                                );
                              },
                              heroTag : '4',
                              backgroundColor:
                              AppCubit.get(context).favourites[model.id]
                                  ? Color.fromRGBO(1, 44, 52, 0.9254901960784314)
                                  : Color.fromRGBO(2, 37, 73, 0.9254901960784314),
                              mini: true,
                              child: Icon(
                                IconBroken.Heart,
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                var username = prefs.getString('username');
                                if( username != null){
                                  AppCubit.get(context).changeCart(
                                    id: model.id,
                                  );
                                }else{
                                  showToast(
                                    text: 'يرجي تسجيل الدخول قبل الأستمرار',
                                    color: ToastColors.ERROR,
                                  );
                                  navigateTo(context, LoginScreen());
                                }

                              },
                              heroTag : '3',
                              backgroundColor: AppCubit.get(context).cart[model.id]
                                  ? Color.fromRGBO(1, 44, 52, 0.9254901960784314)
                                  : Color.fromRGBO(2, 37, 73, 0.9254901960784314),
                              mini: true,
                              child: Icon(
                                IconBroken.Buy,
                              ),
                            ),
                          ],
                        ),*//*
                      ),
                    ),*/
                    if (model.discount != 0)
                      Container(
                        child: Text(
                          appLang(context).discount,
                          style: white12regular(),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        color: Colors.red,
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.price.round()}',
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
                    if (model.discount != 0)

                      Row(
                        children: [
                          Text(

                            '${model.oldPrice.round()}',
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
                            '${model.discount}%',
                            style: black12bold().copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      model.name,
                      maxLines: 2,
                      style: TextStyle(
                        height: 1.4,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}


