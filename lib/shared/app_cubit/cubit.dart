import 'dart:convert';

import 'package:dartz/dartz_streaming.dart';
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

  int categoryId;
  int productsId;
  String productsName;

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
  List<myProduct> products=[];
  List<myProductCart> productsCart=[];
  List<Products> products2=[];
  List<Products> searchList=[];








  getHomeData() {










    emit(AppLoadingState());



    repository
        .getHomeData(
      token: userToken,
    )

        .then((value) {

      homeModel = HomeModel.fromJson(value.data);

        homeModel = HomeModel.fromJson(value.data);
        products2.addAll(homeModel.products);






      products.clear();

      homeModel.products.forEach((element)
      {



       /* List data=[
        ];
        categoryId=26;
        print(categoryId);
        if(categoryId==element.categoryId)


        data.addAll({
          {'name':element.name,'ProductId':element.category,'CatId':element.categoryId,
            'price':element.price,'imageUrl':element.imageUrl},
        });

        data.forEach((element) {
          products.add(myProduct.fromMap(element));
        });
        print('data.length');
       *//* print(products.first.name);*//*
        print(products.first);*/

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

 searchData(String productsName){


 /*  products2.clear();
   searchList.clear();
   homeModel.products.clear();*/
   repository
       .getHomeData(
     token: userToken,
   )

       .then((value) {

     homeModel = HomeModel.fromJson(value.data);
  /*   products2.clear();
     searchList.clear();*/
     searchList=products2.where((search) => search.name.contains(productsName)).toList();

   });



}
  ClearData(){
  searchList.clear();
  print('clear');
  print(searchList.length);
    }




  getCategoriesItems() {

    products.clear();

    homeModel.products.forEach((element)
    {
      List data=[];



      if(categoryId==element.categoryId)
      { print('true');
      data.addAll({
        {'name':element.name,'ProductId':element.category,'CatId':element.categoryId,
          'price':element.price,'imageUrl':element.imageUrl,'description':element.description},
      });

      data.forEach((element) {
        products.add(myProduct.fromMap(element));
      });

      print(products.first.name);


      print(categoryId);}



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



  }

  getCartItems() {

    /*productsCart.clear();*/
      homeModel.products.forEach((element)
      {


        List dataCart=[];

        if(productsId == element.id)
          {
            dataCart.addAll({
            {'name':element.name,'ProductId':element.id,
              'price':element.price,'imageUrl':element.imageUrl},
          }

          );

            dataCart.forEach((element) {
            productsCart.add(myProductCart.fromMap(element));
            print('productsCart.toList()');
            print(productsCart.first.ProductId);




          }


          );


          ;}

      }
      );


  }
  getDeleteItems(int produtsId) {
    print('////////////////////');
    print(produtsId);
    print(productsId);
    print(productsCart);
    if(productsId==produtsId)
      {
        print('true');
      }else
        {
          print('false');
        }

  /* productsCart.removeWhere((element) => element.ProductId == productsId);*/

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

     /* if(addCartModel.status == false)
      {
        changeLocalCart(id);
      }*/

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


class myProduct{
  String name;
  int ProductId;
  int CatId;
  String imageUrl;
  String description;
  dynamic Price;
  myProduct({this.name , this.ProductId,this.CatId, this.imageUrl, this.Price,this.description});
  Map<String,dynamic>toMap(){

    final result=<String,dynamic>{};
    if(name!=null)
      {
        result.addAll({'name':name});
      }
    if(ProductId!=null)
    {
      result.addAll({'ProductId':ProductId});
    }
    if(CatId!=null)
    {
      result.addAll({'CatId':CatId});
    }
  if(description!=null)
  {
  result.addAll({'description':description});
  }
    return result;

  }
  factory myProduct.fromMap(Map<String,dynamic>map){
    return myProduct(
      name: map['name'],
      ProductId: map['ProductId'].hashCode,
      CatId: map['CatId'].hashCode,
      imageUrl: map['imageUrl'],
      Price: map['Price'].hashCode,
      description: map['description']
    );
  }
  StringToJson()=>
      json.encode(toMap());

  factory myProduct.fromJson(String,Source)=>myProduct.fromMap(json.decode(Source));
}

class myProductCart{
  String name;
  int ProductId;
  String imageUrl;
  dynamic Price;
  myProductCart({this.name , this.ProductId, this.imageUrl, this.Price,});
  Map<String,dynamic>toMap(){

    final result=<String,dynamic>{};
    if(name!=null)
    {
      result.addAll({'name':name});
    }
    if(ProductId!=null)
    {
      result.addAll({'ProductId':ProductId});
    }
    if(Price!=null)
    {
      result.addAll({'Price':Price});
    }
    if(imageUrl!=null)
    {
      result.addAll({'imageUrl':imageUrl});
    }


    return result;

  }
  factory myProductCart.fromMap(Map<String,dynamic>map){
    return myProductCart(
        name: map['name'],
        ProductId: map['ProductId'].hashCode,
        imageUrl: map['imageUrl'],
        Price: map['Price'].hashCode,
    );
  }
  StringToJson()=>
      json.encode(toMap());

  factory myProductCart.fromJson(String,Source)=>myProductCart.fromMap(json.decode(Source));
}

