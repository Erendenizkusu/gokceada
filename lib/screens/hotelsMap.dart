import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import '../core/colors.dart';
import '../core/textFont.dart';
import '../product/hotelListCard.dart';


class OtelDetay extends StatefulWidget {
  const OtelDetay({super.key});

  @override
  _OtelDetayState createState() => _OtelDetayState();
}

class _OtelDetayState extends State<OtelDetay> {
  List<Widget> hotels = [];
  List<Widget> hotelsList = [];

  @override
  void initState() {
    super.initState();
    getOtelList();
  }

  void getOtelList() {
    FirebaseFirestore.instance.collection('hotelList').get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        List<String> icon = List<String>.from(doc['icon']);
        String owner = doc['owner'];
        List<String> info = List<String>.from(doc['info']);
        String description = doc['description'];
        String rating = doc['rating'];
        String hotelName = doc['hotel_name'];
        List<String> images = List<String>.from(doc['image']);
        String location = doc['location'];
        String telNo = doc['telNo'];
        List<double> latLng = List<double>.from(doc['latLng']);

        List<ContainerMiddle> facilitiesList = [];

        for(int i = 0; i < icon.length; i++){
          IconData iconData = IconsExtension.getIcon(icon[i]);
          facilitiesList.add(ContainerMiddle(icon: iconData, info: info[i]));
        }

        Widget hotelListWidget = HotelListCard(
            hotelName: hotelName,
            location: location,
            rating: rating,
            list: [images[0],images[1]]);

        Widget hotelWidget = HotelRoomsView(
          latitude: latLng[0],
          longitude: latLng[1],
          owner: owner,
          facilities: facilitiesList,
          description: description,
          hotelName: hotelName,
          list: images,
          location: location,
          telNo: telNo,
        );

        setState(() {
          hotels.add(hotelWidget);
          hotelsList.add(hotelListWidget);
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
        title: Text('Oteller', style: TextFonts.instance.titleFont),
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => hotels[index],
                ),
              );
            },
            child: hotelsList[index],
          );
        },
      ),
    );
  }

}


class IconsExtension {
  static IconData getIcon(String iconName) {
    switch (iconName) {
      case 'air':
        return Icons.air;
      case 'tv':
        return Icons.tv;
      case 'mutfak':
        return Icons.soup_kitchen;
      case 'buzdolabı':
        return Icons.kitchen;
      case 'minibar':
        return Icons.local_bar;
      case 'kasa':
        return Icons.lock;
      case 'balkon':
        return Icons.balcony;
      case 'fön':
        return Icons.barcode_reader;
      case 'çamaşır':
        return Icons.local_laundry_service_outlined;
      case 'vanti':
        return Icons.wind_power;
      default:
        return Icons.error;
    }
  }
}

