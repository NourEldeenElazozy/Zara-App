import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/add_cart/add_cart_model.dart';
import 'package:salla/models/add_fav/add_fav_model.dart';
import 'package:salla/models/cart/cart.dart';
import 'package:salla/models/categories/categories.dart';
import 'package:salla/models/categories/categories2.dart';
import 'package:salla/models/categories/categories2.dart';
import 'package:salla/models/home/home_model.dart';
import 'package:salla/modules/cart/cart_screen.dart';
import 'package:salla/modules/categories/categories_screen.dart';
import 'package:salla/modules/home/home_screen.dart';
import 'package:salla/modules/settings/settings_screen.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/language/app_language_model.dart';
import 'package:salla/shared/network/repository.dart';

class AppCubit extends Cubit<AppStates>
{
  final Repository repository;

  AppCubit(this.repository) : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<bool> selectedLanguage =
  [
    false,
    false,
  ];

  int selectedLanguageIndex;

  void changeSelectedLanguage(int index) {

    selectedLanguageIndex = index;

    for (int i = 0; i < selectedLanguage.length; i++) {
      if (i == index) {
        selectedLanguage[i] = true;
      } else {
        selectedLanguage[i] = false;
      }
    }

    emit(AppSelectLanguageState());
  }

  AppLanguageModel languageModel;
  TextDirection appDirection = TextDirection.ltr;

  Future<void> setLanguage({
    @required String translationFile,
    @required String code,
  }) async {
    languageModel = AppLanguageModel.fromJson(json.decode(translationFile));
    appDirection = code == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    emit(AppSetLanguageState());
  }

  List<Widget> bottomWidgets = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  int categoryId=0;
  int currentIndex = 0;

  void changeBottomIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomIndexState());
  }



  HomeModel homeModel;
  HomeModel homeModel2;
  Map<int, bool> favourites = {};
  Map<int, int> categories = {};
  Map<int, bool> cart = {};
  int cartProductsNumber = 0;





  getHomeData() {
    List<AppImage> images = [
      AppImage(image: "imageUrl", path: "path", active: "active", inactive: "inactive"),

    ];
    AppImage appImage = images[0];
    print(appImage.path);
    for (var i = 0; i < images.length; i++) {

      var currentElement = images[i];
      print(currentElement.image);
    }
    images.forEach((element){
      List<AppImage> images2 = [
        AppImage(image: "imageUrl", path: "path", active: "active", inactive: "inactive"),
      ];
    });


    emit(AppLoadingState());



    repository
        .getHomeData(
      token: userToken,
    )

        .then((value) {

      homeModel = HomeModel.fromJson(value.data);

      homeModel.products.forEach((element)
      {
        final Appimage = <AppImage>[
          for (int i = 0; i < 5; i++)
            AppImage(image: 's', active: 's',inactive: 's',path: 's',),];




print(categoryId);
        if(element.categoryId==categoryId)
        categories.addAll({
          element.id: element.categoryId
        });

        favourites.addAll({
          element.id: element.infavorites
        });
        cart.addAll({
          element.id: element.inCart
        });

        if(element.inCart)
        {
          cartProductsNumber++;
        }
      });


      print(categories);
      print('aaaaaaaaaaaa');
      emit(AppSuccessState(homeModel));

      print(value.data.toString());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorState(error.toString()));
    });
  }

  CategoriesModel2 categoriesModel2;


  CategoriesModel categoriesModel;


  getCategories()
  {

    repository
        .getCategories()
        .then((value)
    {

      categoriesModel2 = CategoriesModel2.fromJson(value.data);

      print(value.data);


      print(value.data);
      emit(AppCategoriesSuccessState());

      print(value.data.toString());
    }).catchError((error) {
      print(error.toString());
      emit(AppCategoriesErrorState(error.toString()));
    });
  }

  CartModel cartModel;

  getCart()
  {
    emit(AppUpdateCartLoadingState());

    repository
        .getCartData(token: userToken)
        .then((value)
    {
      cartModel = CartModel.fromJson(value.data);

      emit(AppCartSuccessState());

      print('success cart');
    }).catchError((error) {
      print('error cart ${error.toString()}');
      emit(AppCartErrorState(error.toString()));
    });
  }

  AddFavModel addFavModel;

  changeFav({
    @required int id,
  }) {
    print(id);

    favourites[id] = !favourites[id];

    emit(AppChangeFavLoadingState());

    repository
        .addOrRemoveFavourite(
      token: userToken,
      id: id,
    )
        .then((value)
    {
      print(value.data);
      addFavModel = AddFavModel.fromJson(value.data);

      if(addFavModel.status == false)
      {
        favourites[id] = !favourites[id];
      }

      emit(AppChangeFavSuccessState());
    }).catchError((error)
    {
      favourites[id] = !favourites[id];
      emit(AppChangeFavErrorState(error.toString()));
    });
  }

  AddCartModel addCartModel;

  changeCart({
    @required int id,
  }) {
    print(id);

    changeLocalCart(id);

    emit(AppChangeCartLoadingState());

    repository
        .addOrRemoveCart(
      token: userToken,
      id: id,
    )
        .then((value)
    {
      print(value.data);
      addCartModel = AddCartModel.fromJson(value.data);

      if(addCartModel.status == false)
      {
        changeLocalCart(id);
      }

      emit(AppChangeCartSuccessState());

      getCart();
    }).catchError((error)
    {
      changeLocalCart(id);

      emit(AppChangeCartErrorState(error.toString()));
    });
  }

  updateCart({
    @required int id,
    @required int quantity,
  }) {
    emit(AppUpdateCartLoadingState());

    repository
        .updateCart(
      token: userToken,
      id: id,
      quantity: quantity,
    )
        .then((value)
    {
      print(value.data);

      getCart();
    }).catchError((error)
    {
      emit(AppUpdateCartErrorState(error.toString()));
    });
  }

  void changeLocalCart(id)
  {
    cart[id] = !cart[id];

    if(cart[id])
    {
      cartProductsNumber++;
    } else
    {
      cartProductsNumber--;
    }

    emit(AppChangeCartLocalState());
  }
}
class AppImage{
  String image;
  String path;
  String active;
  String inactive;

// added '?'

  AppImage({this.image, this.path, this.active, this.inactive});
// can also add 'required' keyword
}


