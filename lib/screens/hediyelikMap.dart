import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/product/PansionListCard.dart';
import 'package:gokceada/screens/surfing.dart';
import '../core/colors.dart';
import '../core/textFont.dart';

class HediyelikDetay extends StatefulWidget {
  const HediyelikDetay({super.key});

  @override
  _HediyelikDetayState createState() => _HediyelikDetayState();
}

class _HediyelikDetayState extends State<HediyelikDetay> {
  List<Widget> hediyelik = [];
  List<Widget> hediyelikList = [];

  @override
  void initState() {
    super.initState();
    getHediyelikList();
  }

  void getHediyelikList() {
    FirebaseFirestore.instance
        .collection('hediyelikList')
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        String link = doc['link'];
        String telNo = doc['telNo'];
        String hediyelikName = doc['hediyelikName'];
        String image = doc['image'];
        String location = doc['location'];
        String rating = doc['rating'];
        List<double> latLng = List<double>.from(doc['latLng']);

        Widget campingListWidget = PansionListCard(
            hotelName: hediyelikName,
            location: location,
            rating: rating,
            path: image);

        Widget campingWidget = SurfingView(
          latitude: latLng[0],
          longitude: latLng[1],
          surfingName: hediyelikName,
          telNo: telNo,
          link: link,
          path: image,
          location: location,
          rating: rating,
        );

        setState(() {
          hediyelik.add(campingWidget);
          hediyelikList.add(campingListWidget);
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
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorConstants.instance.titleColor,
          ),
        ),
        title: Text('Hediyelik Eşyalar', style: TextFonts.instance.titleFont),
      ),
      body: ListView.builder(
        itemCount: hediyelik.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => hediyelik[index],
                ),
              );
            },
            child: hediyelikList[index],
          );
        },
      ),
    );
  }
}
