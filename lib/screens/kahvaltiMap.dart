import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/product/PansionListCard.dart';
import 'package:gokceada/screens/campingDetail.dart';
import '../core/colors.dart';
import '../core/textFont.dart';

class BreakfastDetay extends StatefulWidget {
  const BreakfastDetay({super.key});

  @override
  BreakfastDetayState createState() => BreakfastDetayState();
}

class BreakfastDetayState extends State<BreakfastDetay> {
  List<Widget> breakfast = [];
  List<Widget> breakfastList = [];

  @override
  void initState() {
    super.initState();
    getBreakfastList();
  }

  void getBreakfastList() {
    FirebaseFirestore.instance.collection('breakfastList').get().then((querySnapshot) {

      for (var doc in querySnapshot.docs) {
        String description = doc['description'];
        String breakfastName = doc['breakfast_name'];
        String owner = doc['owner'];
        String image = doc['image'];
        String location = doc['location'];
        String telNo = doc['telNo'];
        String rating = doc['rating'];
        List<double> latLng = List<double>.from(doc['latLng']);



        Widget campingListWidget = PansionListCard(
            hotelName: breakfastName,
            location: location,
            rating: rating,
            path: image);

        Widget campingWidget = CampingDetailView(
          latitude: latLng[0],
          longitude: latLng[1],
          owner: owner,
          description: description,
          campingName: breakfastName,
          path: image,
          location: location,
          telNo: telNo,
          rating: rating,
        );

        setState(() {
          breakfast.add(campingWidget);
          breakfastList.add(campingListWidget);
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
        title: Text('Kahvaltı Alanları', style: TextFonts.instance.titleFont),
      ),
      body: ListView.builder(
        itemCount: breakfast.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => breakfast[index],
                ),
              );
            },
            child: breakfastList[index],
          );
        },
      ),
    );
  }
}

