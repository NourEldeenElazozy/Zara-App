import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/user/user_model.dart';
import 'package:salla/modules/login/cubit/states.dart';
import 'package:salla/modules/register/cubit/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCubit extends Cubit<RegisterStates>
{
  final Repository repository;

  RegisterCubit(this.repository) : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  Register({
    @required String username,
    @required String password,
    @required String confirmPassword,
    @required String phoneNumber,
  })
  {

    repository
        .userRegister(
      username: username,
      password: password,
      confirmPassword: confirmPassword,
      phoneNumber: phoneNumber,
    )
        .then((value)

    async {
print(value.data);
      userModel = UserModel.fromJson(value.data);

      if(userModel.status)
      {
        emit(RegisterSuccessState(userModel));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', username);
        userToken = prefs.getString('username');
        print(userToken);
        print(value.data);
      } else
      {
        emit(RegisterErrorState(userModel.message));

      }
    }).catchError((error)
    {
      print(error.toString());

      emit(RegisterErrorState(error.toString()));


    });
  }
}
