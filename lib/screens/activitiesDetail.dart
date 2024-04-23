import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/hotel_rooms.dart';
import '../product/hotelListCard.dart';

class ActivitiesDetail extends StatefulWidget {
  const ActivitiesDetail(
      {Key? key,
      required this.list,
      required this.description,
      required this.location,
      required this.telNo,
      required this.owner,
      required this.activitiesName})
      : super(key: key);

  final List<String> list;
  final String activitiesName;
  final String description;
  final List<String> owner;
  final String location;
  final List<String> telNo;

  @override
  State<ActivitiesDetail> createState() => _ActivitiesDetailState();
}

class _ActivitiesDetailState extends State<ActivitiesDetail> {
  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    var images = widget.list
        .map((e) => Image.network(
              'https://drive.google.com/uc?export=view&id=$e',
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ))
        .toList();

    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.6,
              child: PageView(controller: _controller, children: images),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                    child: Indicator(controller: _controller, list: images))),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.38,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.white,
                    border: Border.all(
                        width: 1.5, color: ColorConstants.instance.titleColor)),
                height: ((MediaQuery.of(context).size.height) / 2) + 50,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ListView(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.activitiesName,
                              style: TextFonts.instance.titleFont),
                          /*Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                children:[
                              Text('500\$',style: TextFonts.instance.priceFont,),
                                Text('per night',style: TextFonts.instance.commentTextThin,)])*/
                        ],
                      ),
                      Text(widget.location,
                          style: TextFonts.instance.commentTextThin),
                      const SizedBox(height: 20),
                      const Divider(thickness: 2),
                      Text(
                        widget.description,
                        style: TextFonts.instance.commentTextBold,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: widget.telNo.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: OwnerCard(
                                  owner: widget.owner[index],
                                  telNumber: widget.telNo[index],
                                  ),
                            );
                          },
                        ),
                      ),
                    ])),
              ),
            ),
          ],
          //overflow: Overflow.visible,
        ),
      ),
    );
  }
}
