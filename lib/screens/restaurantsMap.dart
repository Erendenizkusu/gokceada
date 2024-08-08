import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/product/restaurantsCard.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import '../core/colors.dart';
import '../core/textFont.dart';


class RestaurantDetay extends StatefulWidget {
  const RestaurantDetay({super.key});

  @override
  _RestaurantDetayState createState() => _RestaurantDetayState();
}

class _RestaurantDetayState extends State<RestaurantDetay> {
  List<Widget> restaurants = [];
  List<Widget> restaurantsList = [];

  @override
  void initState() {
    super.initState();
    getRestaurantList();
  }

  void getRestaurantList() {
    FirebaseFirestore.instance.collection('restaurantList').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        String link = doc['link'];
        String restaurantName = doc['restaurant_name'];
        String image = doc['image'];
        String location = doc['location'];
        String telNo = doc['telNo'];
        String rating = doc['rating'];
        List<double> latLng = List<double>.from(doc['latLng']);


        Widget pansionListWidget = RestaurantsCard(
            restaurantName: restaurantName,
            rating: rating,
            path: image);

        Widget pansionWidget = RestaurantView(
          latitude: latLng[0],
          longitude: latLng[1],
          link: link,
          name: restaurantName,
          path: image,
          location: location,
          telNo: telNo,
          rating: rating,
        );

        setState(() {
          restaurants.add(pansionWidget);
          restaurantsList.add(pansionListWidget);
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
        title: Text('restoranlar'.tr(), style: TextFonts.instance.titleFont),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => restaurants[index],
                ),
              );
            },
            child: restaurantsList[index],
          );
        },
      ),
    );
  }

}

