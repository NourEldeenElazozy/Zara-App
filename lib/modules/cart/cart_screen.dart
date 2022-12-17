import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/layout/home_layout.dart';
import 'package:salla/models/home/home_model.dart';
import 'package:salla/modules/home/home_screen.dart';
import 'package:salla/modules/login/login_screen.dart';
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

import '../../checkout.dart';

class CartScreen extends StatefulWidget {


  CartScreen();

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  myProductCart my;

  @override
  Widget build(BuildContext context) {

   var cartsmodel = AppCubit.get(context).carts;


    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
        onPrimary: Colors.black87,
        primary: Colors.red[300],
        minimumSize: Size(88, 36),
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
        ),);
    return Column(
      children: [
        if (cartsmodel.productsCarts.isNotEmpty)
      Expanded(
          child: Scaffold(

              body: ListView.separated(

                itemCount: cartsmodel.productsCarts.length,
                separatorBuilder: (BuildContext context,
                    int index) => const Divider(),
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          print('items');


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
                                        'http://secommerce-001-site1.etempurl.com/img/${cartsmodel.productsCarts[index].imageUrl}',
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
                                        cartsmodel.productsCarts[index].name,
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
                                                          '${cartsmodel.productsCarts[index].price.round()}',
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
                                Column(
                                  children: [
                                    Container(
                                    child: IconButton(
                               
                                      icon:  Icon(Icons.delete,color:Colors.red ,
                                      ), onPressed: () {
                                      AppCubit.get(context).removeCartItem(cartsmodel.productsCarts[index].id);
                                      AppCubit.get(context).getCartData();
                                      print('cartss count');
                                      print(cartsmodel.productsCarts.length);
                                        setState(() {
                                          AppCubit.get(context).getCartData();
                                          AppCubit.get(context).removeCartItem(cartsmodel.productsCarts[index].id);
                                          print('cartss count');
                                          print(cartsmodel.productsCarts.length);
                                          AppCubit.get(context).getCartData();
                                        });

                                    },


                                    ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  );
                },

              )

          ),
        ),
        if (cartsmodel.productsCarts.isNotEmpty)
        Container(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
            ),
            onPressed: (){

              navigateTo(
                context,
                CheckOut(),
              );

            },
          child: Text('التقدم لإتمام الطلب',style: TextStyle(color: Colors.white),),
          ),
          width: double.infinity,
          height: 50,
        ),
        if (cartsmodel.productsCarts.isEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 140,top: 200,),
            child: Center(
              child: Container(
                child: Text('السلة فارغة',style: TextStyle(fontWeight:FontWeight.bold,fontSize: 30),),
                width: double.infinity,
                height: 50,
              ),
            ),
          ),
      ],
    );
  }
}