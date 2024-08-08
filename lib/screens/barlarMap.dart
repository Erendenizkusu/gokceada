import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/product/restaurantsCard.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import '../core/colors.dart';
import '../core/textFont.dart';

class BarDetay extends StatefulWidget {
  const BarDetay({super.key});

  @override
  BarDetayState createState() => BarDetayState();
}

class BarDetayState extends State<BarDetay> {
  List<Widget> bars = [];
  List<Widget> barsList = [];

  @override
  void initState() {
    super.initState();
    getBarList();
  }

  void getBarList() {
    FirebaseFirestore.instance.collection('barList').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        String link = doc['link'];
        String barName = doc['barName'];
        String image = doc['image'];
        String location = doc['location'];
        String telNo = doc['telNo'];
        String rating = doc['rating'];
        List<double> latLng = List<double>.from(doc['latLng']);


        Widget pansionListWidget = RestaurantsCard(
            restaurantName: barName,
            rating: rating,
            path: image);

        Widget pansionWidget = RestaurantView(
          latitude: latLng[0],
          longitude: latLng[1],
          link: link,
          name: barName,
          path: image,
          location: location,
          telNo: telNo,
          rating: rating,
        );

        setState(() {
          bars.add(pansionWidget);
          barsList.add(pansionListWidget);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.7,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new, color: ColorConstants.instance.titleColor,),
        ),
        title: Text('barlar'.tr(), style: TextFonts.instance.titleFont),
      ),
      body: ListView.builder(
        itemCount: bars.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => bars[index],
                ),
              );
            },
            child: barsList[index],
          );
        },
      ),
    );
  }

}

