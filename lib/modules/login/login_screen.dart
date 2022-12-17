import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();


}

class _LoginScreenState extends State<LoginScreen> {

  bool _isObscure = true;
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Directionality(
      textDirection: AppCubit.get(context).appDirection,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Color.fromRGBO(134, 58, 111, 1.0),),
        body: BlocProvider(
          create: (BuildContext context) => di<LoginCubit>(),
          child: BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {


                    navigateAndFinish(
                      context,
                      HomeLayout(),
                    );

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
                          Image(
                            image: AssetImage('assets/images/logo.png'),
                            height: 220.0,

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
                            controller: emailController,
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
                                icon: Icon(  _isObscure ? Icons.visibility_off : Icons.visibility),
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
                          defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {

                                LoginCubit.get(context).userLogin(
                                  username: emailController.text,
                                  password: passwordController.text,
                                );

                              }
                            },
                            text: appLang(context).login,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                appLang(context).donNotHave,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterScreen()));
                                },
                                child: Text(
                                  appLang(context).registerNow,
                                ),
                              ),
                            ],
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
