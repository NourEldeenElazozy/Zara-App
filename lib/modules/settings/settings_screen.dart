import 'package:flutter/material.dart';
import 'package:salla/layout/home_layout.dart';
import 'package:salla/modules/home/home_screen.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/network/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [
        MaterialButton(
          onPressed: ()
          {
            setAppLanguageToShared('ar')
                .then((value)
            {
              getTranslationFile('ar').then((value)
              {
                AppCubit.get(context).setLanguage(
                  translationFile: value,
                  code: 'ar',
                ).then((value)
                {

                });
              }).catchError((error) {});
            })
                .catchError((error) {});
          },

          child: Text(
            'عربي',
          ),


        ),
        MaterialButton(
          onPressed: ()
          {
            setAppLanguageToShared('en')
                .then((value)
            {
              getTranslationFile('en').then((value)
              {
                AppCubit.get(context).setLanguage(
                  translationFile: value,
                  code: 'en',
                ).then((value)
                {

                });
              }).catchError((error) {});
            })
                .catchError((error) {});
          },

          child: Text(
            'EN',
          ),


        ),
        MaterialButton(
          onPressed: ()
         async {
         SharedPreferences prefs = await SharedPreferences.getInstance();
         var username = prefs.getString('username');
         userToken = prefs.getString('token');
         if( userToken != null){
           SharedPreferences preferences = await SharedPreferences.getInstance();
           await preferences.remove('token');
           showToast(
             text: 'تم تسجيل الخروج بنجاح',
             color: ToastColors.SUCCESS,
           );
         }else{
           showToast(
             text: 'يرجي تسجيل الدخول قبل الأستمرار',
             color: ToastColors.ERROR,
           );
         }


          },

          child: Text(
            'تسجيل خروج',
          ),


        ),

      ],
    );

  }
}
