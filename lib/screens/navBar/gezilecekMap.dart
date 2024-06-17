import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/product/descriptionNetworkImage.dart';
import 'package:gokceada/product/navigationButton.dart';
import '../../core/colors.dart';
import '../../core/textFont.dart';
import '../../product/networkCardDesign.dart';

class GezilecekDetay extends StatefulWidget {
  const GezilecekDetay({Key? key}) : super(key: key);

  @override
  _GezilecekDetayState createState() => _GezilecekDetayState();
}

class _GezilecekDetayState extends State<GezilecekDetay> {
  List<Widget> gezilecek = [];
  List<Widget> gezilecekList = [];

  @override
  void initState() {
    super.initState();
    getGezilecekList();
  }

  void getGezilecekList() {
    FirebaseFirestore.instance.collection('gezilecekList').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        String gezilecekName = doc['gezilecekName'];
        List<String> images = List<String>.from(doc['image']);
        String description = doc['description'];
        List<double> latLng = List<double>.from(doc['latLng']);


        Widget gezilecekListWidget = NetworkCardDesign(
            cardText: gezilecekName,
            path: images[0]);


        Widget gezilecekWidget = NetworkImageDescription(
          description: description,
          title: gezilecekName,
          list: images,
          widget: NavigationButton(latitude: latLng[0],longitude: latLng[1]),
        );

        setState(() {
          gezilecek.add(gezilecekWidget);
          gezilecekList.add(gezilecekListWidget);
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
        title: Text('gormeyeDeger'.tr(), style: TextFonts.instance.appBarTitleColor),
      ),
      body: ListView.builder(
        itemCount: gezilecek.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => gezilecek[index],
                ),
              );
            },
            child: gezilecekList[index],
          );
        },
      ),
    );
  }

}

