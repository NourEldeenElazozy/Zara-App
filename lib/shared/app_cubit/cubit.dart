import 'dart:convert';

import 'package:dartz/dartz_streaming.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/add_cart/add_cart_model.dart';
import 'package:salla/models/add_fav/add_fav_model.dart';
import 'package:salla/models/cart/cart.dart';

import 'package:salla/models/cart/cart2.dart';
import 'package:salla/models/categories/categories.dart';
import 'package:salla/models/categories/categories2.dart';
import 'package:salla/models/categories/categories2.dart';
import 'package:salla/models/home/home_model.dart';
import 'package:salla/modules/cart/cart_screen.dart';
import 'package:salla/modules/categories/categories_screen.dart';
import 'package:salla/modules/home/home_screen.dart';
import 'package:salla/modules/login/cubit/cubit.dart';
import 'package:salla/modules/settings/settings_screen.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/language/app_language_model.dart';
import 'package:salla/shared/network/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';



//الكلاس المسؤول عن ادارة الكيوبت وربطة بscreens
class AppCubit extends Cubit<AppStates>
{
  double Evaluations=0;
  final Repository repository;
  double sum=0.0;
  List <dynamic> comments=[];
  List <dynamic> colors=[];
  List <dynamic> sizes=[];

  AppCubit(this.repository) : super(AppInitialState());

  //اخذ نسخة من لكيوبت لأستخدامها في اي كلاس
  static AppCubit get(context) => BlocProvider.of(context);

  //list of Language
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
//setLanguage Function
  Future<void> setLanguage({
    @required String translationFile,
    @required String code,
  }) async {
    languageModel = AppLanguageModel.fromJson(json.decode(translationFile));
    appDirection = code == 'ar' ? TextDirection.rtl : TextDirection.ltr;

    emit(AppSetLanguageState());
  }
//end function

  //ليست خاصة بالأزرار الخاصة بالويدجت التي تظهر في القائمة السفلية في الابلكيشن
  List<Widget> bottomWidgets = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  int categoryId;
  int productsId;
  String productsName;
  double rating=0.0;

  int currentIndex = 0;

  void changeBottomIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomIndexState());
  }




  HomeModel homeModel; //اخذ نسخة من كلاس HomeModel
  Cart carts; //اخذ نسخة من كلاس Cart
  /*Cart carts;*/
  Images imageModel;
  HomeModel homeModel2;
  Map<int, bool> favourites = {};
  Map<int, int> categories = {};
  Map<int, bool> cart = {};
  int cartProductsNumber = 0;
  List<myProduct> products=[];
  List<myImages> images=[];
  List<myProductCart> productsCart=[];
  List<Products> products2=[];
  List<Products> searchList=[];
  List dataCart=[];
  Cart user;

  final _dio = Dio(); //تعريف مكتبة الديو للأتصال بالApi

  LoginCubit loginCubit;


  //الدالة الخاصة بإضافة اصناف الي االسلة
  //يتم تمرير رقم الصنف الي الدالة لأضفتها الي السلة
  addCartItem(int productid,int colorId , int sizeId) async {

    var product_name;
    try {
      //print('userToken');
      //print(userToken);
      print('-----------------------');
      final value = userToken;
      final res = await _dio.post(
        'http://secommerce-001-site1.etempurl.com/api/Carts/add-product/$productid?colorId=$colorId&sizeId=$sizeId' ,
        options: Options(
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
        ),
      );
      print('-----------------------');
      var product=res.data;
       product_name= product['data']['product'];

      final validMap =
      json.decode(json.encode(product_name)) as Map<String, dynamic>;
      print('map');
      print(validMap['id']);
      print('-----------------------');

      List list = [];





    } catch (e) {
      print(e);
    }
  }

  Future<double>getEvaluations(int productsId) async {


    try {
     // print('userToken');
      //print(userToken);
      final value = userToken;
      final res = await _dio.get(
        'http://secommerce-001-site1.etempurl.com/api/Evaluations/$productsId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('Evaluations2');
      print(res.data);
      sum = res.data.toDouble();
print(sum);







    } catch (e) {
      print(e);
    }
    return sum;
  }

  Future<List>getComments({int productsId}) async {

    try {
      this.productsId=productsId;
      //print('userToken');
      //print(userToken);
      final value = userToken;
      final res = await _dio.get(
        'http://secommerce-001-site1.etempurl.com/api/Comments/$productsId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('productsId');
      print(productsId);
      print('comments');
      print(res.data);
      comments = res.data;
      print('comments2');
      print(comments);







    } catch (e) {
      print(e);
    }
    return comments;
  }
  Future<List>getColors({int productsId}) async {


    try {
      this.productsId=productsId;
      //print('userToken');
      //print(userToken);
      final value = userToken;
      final res = await _dio.get(
        'http://secommerce-001-site1.etempurl.com/api/Colors/$productsId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
        ),
      );
      print('productsId');
      print(productsId);
      print(this.productsId);
      print('colors');
      print(res.data['colors'][0]['name']);

      colors = res.data['colors'];
      print('colors2');
      print(colors[0]['name']);







    } catch (e) {
      print(e);
    }
    return colors;
  }
  Future<List>getSizes({int productsId}) async {


    try {
      this.productsId=productsId;
      //print('userToken');
      //print(userToken);
      final value = userToken;
      final res = await _dio.get(
        'http://secommerce-001-site1.etempurl.com/api/sizes/$productsId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('sizes');
      print(res.data['sizes'][0]['name']);
      sizes = res.data['sizes'];
      print('sizes2');
      print(sizes[0]['name']);







    } catch (e) {
      print(e);
    }
    return colors;
  }
  Future PostComments(int productsId,String content) async {


    try {
      //print('userToken');
      //print(userToken);
      this.productsId=productsId;
      final value = userToken;
      final res = await _dio.post(
        'http://secommerce-001-site1.etempurl.com/api/Comments?productId=$productsId &content=$content',
        options: Options(
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('comments');
      print(res.data);
      comments = res.data;
      print('comments2');
      print(comments);







    } catch (e) {
      print(e);
    }

  }
  Future PostEvaluations(int productsId,double degree) async {

    print('PostEvaluations');
    try {
      //print('userToken');
      //print(userToken);
      this.productsId=productsId;
      final value = userToken;
      final res = await _dio.post(
        'http://secommerce-001-site1.etempurl.com/api/Evaluations?degree=$degree&productId=$productsId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('PostEvaluations2');








    } catch (e) {
      print(e);
    }

  }

  //الدالة الخاصة بإزالة اصناف الي االسلة
  //يتم تمرير رقم الصنف الي الدالة لإزالته الي السلة
  removeCartItem(int productid) async {

    var product_name;
    try {
      //print('userToken');
      //print(userToken);
      final value = userToken;
      final res = await _dio.delete(
        'http://secommerce-001-site1.etempurl.com/api/Carts/remove-product/$productid',
        options: Options(
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
        ),
      );
      print('-----------------------');
      var product=res.data;

    } catch (e) {
      print(e);
    }
  }

  //الدالة الخاصةبإتمام الطلب
  //يتم تمرير رقم السلة الي الدالة لإتمام الطلب
  doneCart(int Cartid , String address) async {


    try {
      //print('userToken');
      //print(userToken);
      final value = userToken;
      final res = await _dio.post(
        'http://secommerce-001-site1.etempurl.com/api/Orders?cartId=$Cartid&address=$address',
        options: Options(
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
        ),
      );
      print('caaaaaaaaaaaaaaaaaaart');
      print(res.data);
      print('caaaaaaaaaaaaaaaaaaart');


    } catch (e) {
      print(e);
    }
  }






  //الدالة الخاصة بجلب جميع الاصناف وعرضها في الصفحة الرئيسية

  getHomeData()  {



    emit(AppLoadingState());



    repository
        .getHomeData(
      token: userToken,
    )

        .then((value) {

      homeModel = HomeModel.fromJson(value.data);
      carts = Cart.fromJson(value.data);

     /*
      print(  homeModel.products[0].images[3].imageUrl);*/

        homeModel = HomeModel.fromJson(value.data);
        products2.addAll(homeModel.products);
         print('products2.length');
        print(products2.length);






      products.clear();

      homeModel.products.forEach((element)
      {
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
      //print(error.toString());
      emit(AppErrorState(error.toString()));
    });

  }

  //الدالة الخاصة بجلب جميع الاصناف الموجودة في السلة وعرضها في صفحة السلة
  getCartData()   async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    userToken= prefs.getString('token');
    final value = userToken;

if (userToken!=null)
  {

    //print('userToken2');


 _dio.get(
      'http://secommerce-001-site1.etempurl.com/api/Carts/get-cart/',
      options: Options(
        headers: {
          'Authorization': 'Bearer $value',
          'Content-Type': 'application/json',
        },
      ),
    )





        .then((value) {
     // print('value.data');
     // print(value.data);

      carts = Cart.fromJson(value.data);
      /*
      print(  homeModel.products[0].images[3].imageUrl);*/





      emit(AppSuccessState(homeModel));

      print(value.data.toString());
    }).catchError((error) {
     // print('error.toString()');
      //print(error.toString());
      emit(AppErrorState(error.toString()));
    });
  }else{
  carts.productsCarts.clear();
  }
  }

  //الدالة الخاصة بالبحث عن الصنف عن طريق تمرير اسم الصنف
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
  /*ClearData(){
  searchList.clear();
  print('clear');
  print(searchList.length);
    }*/


//الدالة الخاصة بجلب الصور الخاصة بالمنتجات
  getImagesItems() {

    images.clear();


        homeModel.products.first.images.forEach((element)
    {
      List imageData=[];




      {
        print('true');
        imageData.addAll({
        {'id':element.id,'ProductId':element.productId,'imageUrl':element.imageUrl,
         },
      });

        imageData.forEach((element) {
        images.add(myImages.fromMap(element));
      });
        print('images.first.imageUrl');
      print(images.first.imageUrl);


      print(categoryId);}





    });


    print(categories);
    print('aaaaaaaaaaaa');
    emit(AppSuccessState(homeModel));



  }

  //الدالة الخاصة بجلب الاصناف حسب التصنيفات
  getCategoriesItems() {

    products.clear();

    homeModel.products.forEach((element)
    {
      List data=[];



      if(categoryId==element.categoryId)
      { print('true');
      data.addAll({
        {'name':element.name,'ProductId':element.id,'CatId':element.categoryId,
          'price':element.price,'imageUrl':element.imageUrl,'description':element.description},
      });

      data.forEach((element) {
        products.add(myProduct.fromMap(element));
      });
      print('products.first.ProductId');
      print(data.first);


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


  /*getDeleteItems(int produtsId) {
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

  *//* productsCart.removeWhere((element) => element.ProductId == productsId);*//*

  }*/

  CategoriesModel2 categoriesModel2;


  CategoriesModel categoriesModel;

//الدالة الخاصة بجلب جميع التصنيفات
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
  double price;
  myProduct({this.name , this.ProductId,this.CatId, this.imageUrl, this.price,this.description});
  Map<String,dynamic>toMap(){

    final result=<String,dynamic>{};
    if(name!=null)
      {
        result.addAll({'name':name});
      }
    if(price!=null)
    {
      result.addAll({'Price':price});
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
        price: map['price'],
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

class myImages{
  int id;
  String imageUrl;
  int productId;
  myImages({this.id , this.imageUrl , this.productId});
  Map<String,dynamic>toMap(){

    final result=<String,dynamic>{};
    if(id!=null)
    {
      result.addAll({'id':id});
    }
    if(imageUrl!=null)
    {
      result.addAll({'imageUrl':imageUrl});
    }
    if(productId!=null)
    {
      result.addAll({'productId':productId});
    }


    return result;

  }
  factory myImages.fromMap(Map<String,dynamic>map){
    return myImages(
      id: map['id'].hashCode,
      productId: map['productId'].hashCode,
      imageUrl: map['imageUrl'],
    );
  }
  StringToJson()=>
      json.encode(toMap());

  factory myImages.fromJson(String,Source)=>myImages.fromMap(json.decode(Source));
}

class CartItems2 {
  String name;
  int id;
  String imageUrl;
  dynamic price;
  CartItems2({this.name, this.id, this.price, this.imageUrl});
  @override
  String toString() {
    return '{ ${this.name}, ${this.price} }';
  }
}