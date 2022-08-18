import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/layout/home_layout.dart';
import 'package:salla/modules/login/cubit/cubit.dart';
import 'package:salla/modules/login/cubit/states.dart';
import 'package:salla/modules/register/register_screen.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/network/local/cache_helper2.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

class CheckOut extends StatelessWidget {









  var addressController = TextEditingController();



  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cartsmodel = AppCubit.get(context).carts;
    return Directionality(
      textDirection: AppCubit.get(context).appDirection,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),),
        body: BlocProvider(
          create: (BuildContext context) => di<LoginCubit>(),
          child: BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {




              }


              if (state is LoginErrorState) {
                showToast(
                  text: 'خطاء في اسم المستخدم او كلمة المرور',
                  color: ToastColors.ERROR,
                );
              }

            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            'ادخل عنوانك',
                            style: black20bold(),
                          ),

                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: addressController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return  'يرجي إدخال العنوان';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                IconBroken.Location,
                              ),
                              labelText: 'العنوان',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                          SizedBox(
                            height: 20.0,
                          ),
                          defaultButton(
                            function: () {
                       if (formKey.currentState.validate()) {

                        AppCubit.get(context).doneCart(cartsmodel.id,addressController.text);
                              Fluttertoast.showToast(
                                  msg: "تمت اضافة الطلبية بنجاح",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                        navigateAndFinish(
                          context,
                          HomeLayout(),
                        );

                        }

                            },
                            text: 'اتمام الطلب',
                          ),
                          SizedBox(
                            height: 10.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  }
