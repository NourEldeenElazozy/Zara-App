



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salla/shared/app_cubit/cubit.dart';

class ItemDetails extends StatelessWidget {

  static const String ITEM_DETAILS_SCREEN = 'item_details';
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(

    onPrimary: Color.fromRGBO(255, 255, 255, 0.9254901960784314),
    primary: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
    minimumSize: const Size.fromHeight(50),
    padding: EdgeInsets.symmetric(horizontal: 20),

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );
   int id;
   String name;
   String image;
  String description;
  List imageList;
  int Listlength;

  ItemDetails(this.id, this.name, this.image,this.description,this.imageList,this.Listlength);

  @override
  Widget build(BuildContext context) {
    var Imagemodel = AppCubit.get(context).homeModel;
    print('Listlength');
    print(Listlength);

    if(description==null){description= "";}

    return Scaffold(

      appBar: AppBar(backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
        title: Text('Zara'),
      ),
      body: Center(
        child: Column(
          children: [

            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),






                  ImageDialog(ItemDetails(id, name, image,description,imageList,Listlength),context),
                  if(Listlength!=0)
                    Center(

                      child: Container(
                          width: double.infinity,
                          height: 100.0,


                          child: ListView.builder(

                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:imageList.length,
                            itemBuilder: (BuildContext context, int index) {

                              return    SizedBox(
                                width: 200,
                                child: Image(
                                  image: NetworkImage(
                                    'http://abdudashapi-001-site1.htempurl.com/img/${imageList[index]}',
                                  ),
                                  //fit: BoxFit.cover,
                                  height: 250.0,
                                ),
                              );
                            },
                          )
                      ),
                    ),

                  SizedBox(
                    height: 12,
                  ),
                  buildDescriptionItem( ItemDetails(id, name, image,description,imageList,Listlength),context),
                  SizedBox(
                    height: 12,
                  ),



                  Container(

                    child: ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: ()
                      {

                        AppCubit.get(context).getCartItems();
                       AppCubit.get(context).productsId= this.id;

                      },
                      child: Text('إضافة الي السلة'),
                    ),
                  )
                ],
              ),

            ),


          ],
        ),
      ),
    );
  }


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
          Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            child: Text(
              item.name,
              style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              item.description,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.grey,
                height: 1.3,
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
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

          'http://abdudashapi-001-site1.htempurl.com/img/${item.image}',
          ),
          //fit: BoxFit.cover,
          height: 250.0,
        ),
      ),
    );
  }


