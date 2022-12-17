





import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/modules/login/login_screen.dart';
import 'package:salla/modules/register/register_screen.dart';
import 'package:salla/modules/single_category/single_category_screen2.dart';
import 'package:salla/shared/app_cubit/cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:swipe/swipe.dart';
class ItemDetails extends StatefulWidget {


  static const String ITEM_DETAILS_SCREEN = 'item_details';

   int id;
   String name;
   String image;
  double price;
  String description;
  List imageList;
  int Listlength;
 List Colors=[];



  ItemDetails(this.id, this.name, this.image,this.description,this.imageList,this.Listlength,this.price);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();


}

class _ItemDetailsState extends State<ItemDetails> {
  int _value = 1;
  int _Sizesvalue;
  int _Colorsvalue;
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(


    onPrimary: Color.fromRGBO(255, 255, 255, 0.9254901960784314),
    primary: Color.fromRGBO( 251, 37, 118, 1.0),
    minimumSize: const Size.fromHeight(50),
    padding: EdgeInsets.symmetric(horizontal: 20),

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  final _ratingController = TextEditingController();

  double _rating;

  double _userRating = 3.0;

  int _ratingBarMode = 1;

  bool _isRTLMode = true;

  bool _isVertical = false;

  IconData _selectedIcon;
  @override
  void dispose() {
    // Never called

    print("Disposing first route");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    @override


    var Imagemodel = AppCubit.get(context).homeModel;
     List<dynamic> comments = AppCubit.get(context).comments;
    List colors=[];
    List sizes=[];
    colors.clear();
    colors = AppCubit.get(context).colors;

    //var getcurrent=AppCubit.get(context).getCurrent();
     sizes = AppCubit.get(context).sizes;
    List<String> countries = ["Brazil", "Nepal", "India", "China", "USA", "Canada"];
    //getcurrent;

    if(widget.description==null){widget.description= "";}

    //عداد
    /*
    if(current<=20){
      Future.delayed(const Duration(milliseconds: 1000), () {
        for (current = 0; current <= 20; current++) {
          setState(() {
            print("Innerloop2: ${current}");
          });
        }});
    }
    if(current>=20){
      current=0;
    }
     */
//
   // if(current<=20){

        //setState(() {
          //current=current+1;
          //print('current2');
          //print(current);
        //});
      //}



    return Directionality(
        textDirection:TextDirection.rtl,
      child: Scaffold(

        appBar: AppBar(backgroundColor: Color.fromRGBO(
            251, 37, 118, 1.0),
          title: Text('P I N K'),
        ),
        body: Swipe(
          onSwipeDown: () {
            setState(() {

            });
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [

                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),






                        ImageDialog(ItemDetails(widget.id, widget.name, widget.image,widget.description,widget.imageList,widget.Listlength,widget.price),context),
                        if(widget.Listlength!=0)
                          Center(

                            child: Container(
                                width: double.infinity,
                                height: 100.0,


                                child: ListView.builder(

                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:widget.imageList.length,
                                  itemBuilder: (BuildContext context, int index) {

                                    return    Row(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          child: Image(
                                            image: NetworkImage(
                                              'http://secommerce-001-site1.etempurl.com/img/${widget.imageList[index]}',
                                            ),
                                            //fit: BoxFit.cover,
                                            height: 100.0,
                                          ),

                                        ),

                                      ],
                                    );
                                  },
                                )
                            ),
                          ),



                        buildDescriptionItem( ItemDetails(widget.id, widget.name, widget.image,widget.description,widget.imageList,widget.Listlength,widget.price),context),
                        SizedBox(
                          height: 12,
                        ),



                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 250,
                                height: 50,
                                child: ElevatedButton(
                                  style: raisedButtonStyle,
                                  onPressed: ()
                                  async {

                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: const Text('يرجي إختيار خصائص المنتج '),

                                    );


                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    userToken = prefs.getString('token');
                                    print('token');
                                    print(userToken);
                                    if(userToken!=null){
                                      if(_Sizesvalue==null || _Colorsvalue ==null){
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                      print('111111111111111111');
                                      //AppCubit.get(context).productsId= this.widget.id;

                                      AppCubit.get(context).addCartItem(AppCubit.get(context).productsId,_Colorsvalue,_Sizesvalue);
                                    }else{
                                      print('22222222222222222222');
                                      navigateTo(context, LoginScreen(),);
                                    }



                                  },
                                  child: Text('إضافة الي السلة'),
                                ),
                              ),
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                                      206, 3, 149, 0.7294117647058823,),),
                                  ),
                                  onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => AlertDialog(
                                      title: const Text('تقييم المنتج',  textAlign: TextAlign.center,),
                                      content: Raiteng(),

                                      actions: <Widget>[



                                      ],
                                    ),
                                  ),
                                  child: Text("تقييم المنتج"),


                                ),
                              ),


                            ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:Container(
                             width: 400,
                               height: 50.0,
                              color: Colors.white,

                                   ///Get Colors
                               child: FutureBuilder(
                                 future: AppCubit.get(context).getColors(productsId:AppCubit.get(context).productsId ),
                                 builder: (context, dataSnapshot) {
                                   colors.clear();
                                   colors=AppCubit.get(context).colors;
                                   print('colors22222');
                                   print(colors);
                                   if (dataSnapshot.connectionState == ConnectionState.waiting) {
                                     return Center(
                                       child: CircularProgressIndicator(),
                                     );
                                   } else {
                                     if (dataSnapshot.error != null) {
                                       return Center(
                                         child: Text('لايوجد بيانات'),
                                       );
                                     } else {



                                           return
                                             Row(

                                               children: [

                                             Wrap(
                                             children: List<Widget>.generate(
                                               colors.length,
                                                   (int index) {
                                                 return ChoiceChip(
                                                   selectedColor: Color.fromRGBO(
                                                       43, 58, 85, 1.0),
                                                   backgroundColor: Color.fromRGBO(
                                                       151, 92, 141, 1.0),
                                                   label: Text(colors[index]['name'],style: TextStyle(
                                                     color: Colors.white
                                                   ),),
                                                   selected: _Colorsvalue == index,
                                                   onSelected: (bool selected) {
                                                     setState(() {
                                                       _Colorsvalue = selected ? index : null;
                                                     });
                                                   },
                                                 );
                                               },
                                             ).toList(),
                                           ),

                                               ],
                                             );



                                     }
                                   }
                                 },
                               ),

                           )
                        ),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:Container(
                                width: 400,
                                height: 50.0,
                                color: Colors.white,


                                child:  FutureBuilder(
                                  future: AppCubit.get(context).getSizes(productsId:AppCubit.get(context).productsId),
                                  builder: (context, dataSnapshot) {
                                    sizes.clear();
                                    sizes=AppCubit.get(context).sizes;
                                    print('sizes22222');
                                    print(sizes);
                                    if (dataSnapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      if (dataSnapshot.error != null) {
                                        return Center(
                                          child: Text('لايوجد بيانات'),
                                        );

                                      } else {


                                            return
                                              Row(

                                                children: [
                                               Wrap(
                                              children: List<Widget>.generate(
                                                sizes.length,
                                                (int index) {
                                                return ChoiceChip(
                                                selectedColor: Color.fromRGBO(
                                                43, 58, 85, 1.0),
                                                backgroundColor: Color.fromRGBO(
                                                151, 92, 141, 1.0),
                                                label: Text(sizes[index]['name'],style: TextStyle(
                                                color: Colors.white
                                                ),),
                                                selected: _Sizesvalue == index,
                                                onSelected: (bool selected) {
                                                setState(() {
                                                  _Sizesvalue = selected ? index : null;
                                                });
                                                },
                                                );
                                                },
                                                ).toList(),
                                                ),

                                                ],
                                              );


                                      }
                                    }
                                  },
                                )

                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [

                            Container(
                                height: 100,
                                width:300,
                                child: FutureBuilder(
                                  future: AppCubit.get(context).getComments(productsId:AppCubit.get(context).productsId),
                                builder: (context, dataSnapshot) {
                                  comments.clear();
                                  comments=AppCubit.get(context).comments;
                                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    if (dataSnapshot.error != null) {
                                      return Center(
                                        child: Text('لايوجد بيانات'),
                                      );
                                     } else {
                                   return ListView.builder(
                                       itemCount: comments.length,
                                       itemBuilder: (BuildContext context, int index) {
                                         return ListTile(
                                             leading: const Icon(Icons.comment),

                                             title: Text(comments[index]['content']));
                                       });
            }
          }
      },
    ),
                            ),


                          ],

                        ),


                      ],
                    ),

                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSmallImage(List<dynamic> images, int indexImage) {

    return GestureDetector(

      child: Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(right: 8),
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          border: Border.all(

          ),
          borderRadius: BorderRadius.circular(10),
        ),

      ),
    );
  }

  Widget buildDescriptionItem( ItemDetails item , context) {

    var getEvaluations = AppCubit.get(context).getEvaluations(item.id);
    var getComments = AppCubit.get(context).getComments(productsId: item.id);
    var getColors = AppCubit.get(context).getColors(productsId: item.id);
    var getSizes = AppCubit.get(context).getSizes(productsId: item.id);
    getEvaluations;

   // getColors;

    //getSizes;

    var sum = AppCubit.get(context).sum;

print('sum');
    print(this.widget.id);
    print(sum);


    return Container(
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [

              Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(

                      children: [
                        Row(
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              Text(
                                ' ${item.price.round()} دينار' ,
                                style: Theme.of(context).textTheme.headline6.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ]
                        ),
                        Container(
                          width: 200,

                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                             item.description,
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.grey,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AbsorbPointer(
                      absorbing: true,
                      child: Container(
                        height: 10,
                        width: 150,

                        child:RatingBar.builder(
                          itemSize: 20,
                          initialRating:  sum,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),

                      ),
                    ),



                  ],
                ),

              ),



            ],
          ),



        ],
      ),
    );
  }

  Widget ImageDialog(ItemDetails item , context) {
    return Dialog(
      child: AnimatedContainer(
        duration: Duration(seconds: 200),
        child:  Image(
          image: NetworkImage(

            'http://secommerce-001-site1.etempurl.com/img/${item.image}',
          ),
          //fit: BoxFit.cover,
          height: 250.0,
        ),
      ),
    );
  }
}






class Tadawal extends StatefulWidget {

  @override
  _Tadawal createState() => _Tadawal();
}
class _Tadawal extends State<Tadawal> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final commnet  = TextEditingController();
  Widget build(BuildContext context) {





    return Container(
      height: 150,
      child: Scaffold(

        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(

                  children: [

                    TextFormField(

                      controller:   commnet,
                      validator: (value) {

                        if (value == null || value.isEmpty) {
                          return 'هذة الحقل مطلوب';
                        }

                        return null;
                      },

                      textAlign: TextAlign.center,
                      onChanged: (value) {

                      },

                      decoration: InputDecoration(hintText: "ادخل المحتوي",

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                            206, 3, 149, 0.7294117647058823,),),
                        ),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {

                            AppCubit.get(context).PostComments(AppCubit.get(context).productsId, commnet.text);
                            AppCubit.get(context).PostEvaluations(AppCubit.get(context).productsId, AppCubit.get(context).rating)

                                .then((value) =>
                                Fluttertoast.showToast(
                                  msg: 'تم ارسال التقييم بنجاح',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                ))

                         ;

                         Navigator.pop(context);
                          }

                        },
                        child: const Text('إرسال'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Raiteng extends StatefulWidget {
  @override
  _Raiteng createState() => _Raiteng();
}

class _Raiteng extends State<Raiteng> {
  final _ratingController = TextEditingController();
  double _rating;
  double _userRating = 3.0;
  int _ratingBarMode = 1;
  bool _isRTLMode = true;
  bool _isVertical = false;
  IconData _selectedIcon;

  @override
  void initState() {
    _ratingController.text = '3.0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 195,

      child: Scaffold(

        body: Builder(
          builder: (context) => Scaffold(

            body: Directionality(
              textDirection: _isRTLMode ? TextDirection.rtl : TextDirection.ltr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RatingBar.builder(
                    itemSize: 30,
                    initialRating:  0,
                    minRating: 1,
                    direction: Axis.horizontal,

                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      AppCubit.get(context).rating=rating;

                      print(rating);
                    },
                  ),

                  SizedBox(
                    height: 5.0,

                  ),


                  Tadawal(),







                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  Widget ratingBar(int mode) {
    switch (mode) {
      case 1:
        return Center(
          child: RatingBar.builder(
            initialRating: 2,
            minRating: 0,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            allowHalfRating: false,
            unratedColor: Colors.amber.withAlpha(50),
            itemCount: 5,
            itemSize: 37.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              _selectedIcon ?? Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
            updateOnDrag: true,
          ),
        );

      default:
        return Container();
    }
  }




}


