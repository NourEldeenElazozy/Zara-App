



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {

  static const String ITEM_DETAILS_SCREEN = 'item_details';
   int id;
   String name;
   String image;
  String description;
  ItemDetails(this.id, this.name, this.image,this.description);

  @override
  Widget build(BuildContext context) {
    if(description==null){description= "";}

    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(2, 37, 73, 0.9254901960784314),
        title: Text('Zara'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),


              ImageDialog(ItemDetails(id, name, image,description),context),

              SizedBox(
                height: 12,
              ),
              buildDescriptionItem( ItemDetails(id, name, image,description),context),
            ],
          ),

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

              'http://abdudashapi-001-site1.htempurl.com/img/${item.image}'
          ),
          //fit: BoxFit.cover,
          height: 250.0,
        ),
      ),
    );
  }
