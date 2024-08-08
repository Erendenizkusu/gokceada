import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/product/restaurantsCard.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import 'cafeView.dart';

class CafeDetay extends StatefulWidget {
  const CafeDetay({super.key});

  @override
  CafeDetayState createState() => CafeDetayState();
}

class CafeDetayState extends State<CafeDetay> {
  List<Widget> cafes = [];
  List<Widget> cafesList = [];

  @override
  void initState() {
    super.initState();
    getCafeList();
  }

  void getCafeList() {
    FirebaseFirestore.instance.collection('cafeList').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        String link = doc['link'];
        String cafeName = doc['cafeName'];
        String image = doc['image'];
        String location = doc['location'];
        String rating = doc['rating'];
        List<double> latLng = List<double>.from(doc['latLng']);


        Widget pansionListWidget = RestaurantsCard(
            restaurantName: cafeName,
            rating: rating,
            path: image);

        Widget pansionWidget = CafeView(
          latitude: latLng[0],
          longitude: latLng[1],
          link: link,
          name: cafeName,
          path: image,
          location: location,
          rating: rating,
        );

        setState(() {
          cafes.add(pansionWidget);
          cafesList.add(pansionListWidget);
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
          icon: Icon(Icons.arrow_back_ios_new, color: ColorConstants.instance.titleColor),
        ),
        title: Text('kafeler'.tr(), style: TextFonts.instance.titleFont),
      ),
      body: ListView.builder(
        itemCount: cafes.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => cafes[index],
                ),
              );
            },
            child: cafesList[index],
          );
        },
      ),
    );
  }

}

