import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/user/user_model.dart';
import 'package:salla/modules/login/cubit/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/repository.dart';

class LoginCubit extends Cubit<LoginStates>
{
  final Repository repository;

  LoginCubit(this.repository) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel userModel;

  userLogin({
    @required String username,
    @required String password,
  })
  {

    repository
        .userLogin(
      username: username,
      password: password,
    )
        .then((value)
    {

      userModel = UserModel.fromJson(value.data);

      if(userModel.status)
      {
        emit(LoginSuccessState(userModel));

        print(value.data);

      } else
      {
        emit(LoginErrorState(userModel.message));
      }
    }).catchError((error)
    {

      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
