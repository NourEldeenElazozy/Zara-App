import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/home/home_model.dart';
import 'package:salla/modules/single_category/cubit/cubit.dart';
import 'package:salla/modules/single_category/cubit/states.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/app_cubit/states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/di/di.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/icon_broken.dart';
import 'package:salla/shared/styles/styles.dart';

import 'item_screen.dart';



class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var SearchController = TextEditingController();
  String productsName;
  @override

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).searchData(SearchController.text);
   /*  AppCubit.get(context).ClearData();*/
    var searchModel = AppCubit.get(context).searchList;

   /* if(searchModel.length==0){
      AppCubit.get(context).ClearData();
    }*/


    print('searchModel.length');
    print(searchModel.length);

     return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
        title: Center(child: const Text('Search')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
       child:Column(
         children: [
           TextFormField(

             onChanged: (productsName) {
               productsName=productsName;
             /*  AppCubit.get(context).ClearData();*/
               AppCubit.get(context).searchData(productsName);

              setState(() {
                AppCubit.get(context).searchData(productsName);
              });

             },
             controller: SearchController,

             decoration: InputDecoration(
               prefixIcon: Icon(
                 IconBroken.Search,
               ),
               labelText: 'المنتج',
               border: OutlineInputBorder(),
             ),
           ),
           Expanded(child:
           ListView.separated(
             itemCount: searchModel.length,
             separatorBuilder: (BuildContext context,
                 int index) => const Divider(color: Colors.red,),
             physics: BouncingScrollPhysics(),
             itemBuilder: (BuildContext context, int index) {
               return InkWell(
                 onTap: () {

                  navigateTo(context, ItemDetails(searchModel[index].id,searchModel[index].name,searchModel[index].imageUrl,searchModel[index].description,[],0,searchModel[index].price),);
                 },
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Container(
                     height: 130.0,
                     child: Row(
                       children: [
                         Container(
                           height: 130.0,
                           width: 130.0,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(
                               2.0,
                             ),
                             image: DecorationImage(
                               image: NetworkImage(
                                 'http://abdudashapi-001-site1.htempurl.com/img/${searchModel[index].imageUrl}',
                               ),
                               fit: BoxFit.cover,
                             ),
                           ),
                         ),
                         SizedBox(
                           width: 20.0,
                         ),
                         Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children:
                             [

                               Text(
                                 searchModel[index].name,
                                 maxLines: 2,
                                 style: TextStyle(
                                   height: 1.4,
                                 ),
                                 overflow: TextOverflow.ellipsis,
                               ),
                               SizedBox(
                                 height: 10.0,
                               ),
                               Spacer(),
                               BlocConsumer<AppCubit, AppStates>(
                                 listener: (context, state) {},
                                 builder: (context, state) {
                                   return Row(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Expanded(
                                         child: Column(
                                           children:
                                           [
                                             Row(
                                               children: [
                                                 Text(
                                                   '${searchModel[index].price.round()}',
                                                   style: black16bold().copyWith(
                                                     height: .5,
                                                     color: defaultColor,
                                                   ),
                                                 ),
                                                 SizedBox(
                                                   width: 5.0,
                                                 ),
                                                 Text(
                                                   appLang(context).currency,
                                                   style: black12bold().copyWith(
                                                     height: .5,
                                                     color: defaultColor,
                                                   ),
                                                 ),
                                               ],
                                             ),

                                           ],
                                         ),
                                       ),
                                       /*FloatingActionButton(
                                onPressed: ()
                                {
                                  AppCubit.get(context).changeFav(
                                    id: model.id,
                                  );
                                },
                                heroTag : '2',
                                backgroundColor:
                                AppCubit.get(context).favourites[model.id]
                                    ? Colors.green
                                    : null,
                                mini: true,
                                child: Icon(
                                  IconBroken.Heart,
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  AppCubit.get(context).changeCart(
                                    id: model.id,
                                  );
                                },
                                heroTag : '1',
                                backgroundColor: AppCubit.get(context).cart[model.id]
                                    ? Colors.green
                                    : null,
                                mini: true,
                                child: Icon(
                                  IconBroken.Buy,
                                ),
                              ),*/
                                     ],
                                   );
                                 },
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               );
             },

           ),)
         ],
       )
      ),
     );
  }
}