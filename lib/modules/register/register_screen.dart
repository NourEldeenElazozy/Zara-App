import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/home_layout.dart';
import 'package:salla/modules/login/cubit/cubit.dart';
import 'package:salla/modules/register/cubit/cubit.dart';
import 'package:salla/modules/register/cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';


class RegisterScreen extends StatelessWidget {

  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => di<RegisterCubit>(),
     child: BlocConsumer<RegisterCubit,RegisterStates>(
      listener: (context , state){
        if (state is RegisterSuccessState) {


          navigateAndFinish(
            context,
            HomeLayout(),
          );

        }
        if (state is RegisterErrorState) {
          showToast(
            text: 'خطاء في البيانات المدخلة',
            color: ToastColors.ERROR,
          );
        }
      },
      builder: (context , state){
        return  Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/logo.jpg'),
                        height: 150.0,
                      ),
                      Text(
                        appLang(context).loginTitle,
                        style: black20bold(),
                      ),
                      Text(
                        appLang(context).loginSubTitle,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: userNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return appLang(context).user_name;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            IconBroken.User,
                          ),
                          labelText: appLang(context).user_name,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: phoneNumberController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return appLang(context).phone;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            IconBroken.Call,
                          ),

                          labelText: appLang(context).phone,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return appLang(context).passwordValidation;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            IconBroken.Lock,
                          ),
                          suffixIcon: Icon(
                            IconBroken.Show,
                          ),
                          labelText: appLang(context).password,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return appLang(context).confirmPassword;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            IconBroken.Lock,
                          ),
                          suffixIcon: Icon(
                            IconBroken.Show,
                          ),
                          labelText: appLang(context).confirmPassword,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: () {
                          if (formKey.currentState.validate()) {
                            RegisterCubit.get(context).Register(
                              username: userNameController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                              phoneNumber: phoneNumberController.text,

                            );
                          }
                        },
                        text: appLang(context).registerNow,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    )

    );
  }

  }
