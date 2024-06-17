import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/product/PansionListCard.dart';
import 'package:gokceada/screens/surfing.dart';
import '../core/colors.dart';
import '../core/textFont.dart';

class SurfingDetay extends StatefulWidget {
  const SurfingDetay({Key? key}) : super(key: key);

  @override
  _SurfingDetayState createState() => _SurfingDetayState();
}

class _SurfingDetayState extends State<SurfingDetay> {
  List<Widget> surfing = [];
  List<Widget> surfingList = [];

  @override
  void initState() {
    super.initState();
    getSurfingList();
  }

  void getSurfingList() {
    FirebaseFirestore.instance.collection('surfingList').get().then((querySnapshot) {

      for (var doc in querySnapshot.docs) {
        String link = doc['link'];
        String owner = doc['owner'];
        String surfingName = doc['restaurant_name'];
        List<String> images = List<String>.from(doc['image']);
        String location = doc['location'];
        String telNo = doc['telNo'];
        String rating = doc['rating'];
        List<double> latLng = List<double>.from(doc['latLng']);



        Widget campingListWidget = PansionListCard(
            hotelName: surfingName,
            location: location,
            rating: rating,
            list: [images[0],images[1]]);

        Widget campingWidget = SurfingView(
          latitude: latLng[0],
          longitude: latLng[1],
          surfingName: surfingName,
          link: link,
          name: owner,
          list: images,
          location: location,
          telNo: telNo,
          rating: rating,
        );

        setState(() {
          surfing.add(campingWidget);
          surfingList.add(campingListWidget);
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
        title: Text('surfOkullari'.tr(), style: TextFonts.instance.titleFont),
      ),
      body: ListView.builder(
        itemCount: surfing.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => surfing[index],
                ),
              );
            },
            child: surfingList[index],
          );
        },
      ),
    );
  }

}

