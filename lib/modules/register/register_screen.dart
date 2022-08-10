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


class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = true;
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
          appBar: AppBar(backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),),
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
                        image: AssetImage('assets/images/logo.png'),
                        height: 150.0,
                      ),
                      Text(
                        appLang(context).registerNow,
                        style: black20bold(),
                      ),
                      Text(
                        appLang(context).loginSubTitle,
                      ),

                      TextFormField(
                        controller: userNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return appLang(context).emailValidation;
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
                            return 'يرجي إدخال رقم الهاتف';
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
                        obscureText: _isObscure,
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
                          suffixIcon: IconButton(
                            icon: Icon( _isObscure ? Icons.visibility_off : Icons.visibility),
                            onPressed: (){
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },

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
                        obscureText: _isObscure,
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
                          suffixIcon: IconButton(
                            icon: Icon( _isObscure ? Icons.visibility_off : Icons.visibility),
                            onPressed: (){
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },

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
