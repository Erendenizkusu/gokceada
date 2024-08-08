import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/product/PansionListCard.dart';
import 'package:gokceada/screens/campingDetail.dart';
import '../core/colors.dart';
import '../core/textFont.dart';


class CampingDetay extends StatefulWidget {
  const CampingDetay({super.key});

  @override
  CampingDetayState createState() => CampingDetayState();
}

class CampingDetayState extends State<CampingDetay> {
  List<Widget> camping = [];
  List<Widget> campingList = [];

  @override
  void initState() {
    super.initState();
    getCampingList();
  }

  void getCampingList() {
    FirebaseFirestore.instance.collection('campingList').get().then((querySnapshot) {

      for (var doc in querySnapshot.docs) {
        String description = doc['description'];
        String pansionName = doc['camping_name'];
        String image = doc['image'];
        String location = doc['location'];
        String telNo = doc['telNo'];
        String rating = doc['rating'];
        List<double> latLng = List<double>.from(doc['latLng']);



        Widget campingListWidget = PansionListCard(
            hotelName: pansionName,
            location: location,
            rating: rating,
            path: image,);

        Widget campingWidget = CampingDetailView(
          latitude: latLng[0],
          longitude: latLng[1],
          description: description,
          campingName: pansionName,
          path: image,
          location: location,
          telNo: telNo,
          rating: rating,
        );

        setState(() {
          camping.add(campingWidget);
          campingList.add(campingListWidget);
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
        title: Text('kampalanlari'.tr(), style: TextFonts.instance.titleFont),
      ),
      body: ListView.builder(
        itemCount: camping.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => camping[index],
                ),
              );
            },
            child: campingList[index],
          );
        },
      ),
    );
  }

}

