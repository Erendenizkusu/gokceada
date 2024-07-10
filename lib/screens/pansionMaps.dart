import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/product/PansionListCard.dart';
import 'package:gokceada/screens/pansionDetail.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import 'hotel_rooms.dart';
import 'hotelsMap.dart';

class PansionDetay extends StatefulWidget {
  const PansionDetay({super.key});

  @override
  _PansionDetayState createState() => _PansionDetayState();
}

class _PansionDetayState extends State<PansionDetay> {
  List<Widget> pansions = [];
  List<Widget> pansionList = [];

  @override
  void initState() {
    super.initState();
    getPansionList();
  }

  void getPansionList() {
    FirebaseFirestore.instance.collection('pansionList').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        List<String> icon = List<String>.from(doc['icon']);
        String owner = doc['owner'];
        List<String> info = List<String>.from(doc['info']);
        String description = doc['description'];
        String pansionName = doc['pansion_name'];
        List<String> images = List<String>.from(doc['image']);
        String location = doc['location'];
        String telNo = doc['telNo'];
        String rating = doc['rating'];
        List<ContainerMiddle> facilitiesList = [];
        List<double> latLng = List<double>.from(doc['latLng']);

        for (int i = 0; i < icon.length; i++) {
          IconData iconData = IconsExtension.getIcon(icon[i]);
          facilitiesList.add(ContainerMiddle(icon: iconData, info: info[i]));
        }

        Widget pansionListWidget = PansionListCard(
            hotelName: pansionName,
            location: location,
            rating: rating,
            list: [images[0],images[1]]);

        Widget pansionWidget = PansionDetailView(
          latitude: latLng[0],
          longitude: latLng[1],
          owner: owner,
          facilities: facilitiesList,
          description: description,
          pansion_name: pansionName,
          list: images,
          location: location,
          telNo: telNo,
          rating: rating,
        );

        setState(() {
          pansions.add(pansionWidget);
          pansionList.add(pansionListWidget);
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
        title: Text('pansionlar'.tr(), style: TextFonts.instance.titleFont),
      ),
      body: ListView.builder(
        itemCount: pansions.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pansions[index],
                ),
              );
            },
            child: pansionList[index],
          );
        },
      ),
    );
  }
  
}

