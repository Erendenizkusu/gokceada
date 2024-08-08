import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/product/imagePageView.dart';
import 'package:url_launcher/url_launcher.dart';
import '../product/countIndicator.dart';
import '../product/navigationButton.dart';

class HotelRoomsView extends StatefulWidget {
  const HotelRoomsView(
      {super.key,
      required this.description,
      required this.location,
      required this.hotelName,
      required this.facilities,
      required this.owner,
      required this.latitude,
      required this.longitude,
      required this.telNo,
      required this.path});

  final double latitude;
  final double longitude;
  final String hotelName;
  final String description;
  final String location;
  final List<ContainerMiddle> facilities;
  final String owner;
  final String telNo;
  final String path;

  @override
  State<HotelRoomsView> createState() => _HotelRoomsViewState();
}

class _HotelRoomsViewState extends State<HotelRoomsView> {
  late PageController _controller;
  int imageCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  void onImageCountUpdated(int count) {
    setState(() {
      imageCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              height: (MediaQuery.of(context).size.height) * 0.35,
              child: ImagePageView(
                  folderPath: widget.path,
                  controller: _controller,
                  onImageCountUpdated: onImageCountUpdated),
            ),
            Positioned(
                top: 20,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                )),
          ]),
          Center(
              child:
                  CountIndicator(controller: _controller, count: imageCount)),
          const SizedBox(height: 10),
          Center(
            child: NavigationButton(
                latitude: widget.latitude, longitude: widget.longitude),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                width: 350,
                child:
                    Text(widget.hotelName, style: TextFonts.instance.titleFont),
              ),
              const SizedBox(height: 20),
              Text(widget.location, style: TextFonts.instance.commentTextThin),
              const SizedBox(height: 20),
              Text('tesisOzellikleri'.tr(),
                  style: TextFonts.instance.middleTitle),
              const SizedBox(height: 20),
              Text(
                widget.description,
                style: TextFonts.instance.commentTextBold,
              ),
              const SizedBox(height: 40),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('odaOzellikleri'.tr(),
                    style: TextFonts.instance.middleTitle),
                const SizedBox(height: 20),
                Wrap(children: widget.facilities),
              ]),
              const SizedBox(height: 20),
              OwnerCard(
                owner: widget.owner,
                telNumber: widget.telNo,
              ),
              const SizedBox(height: 20),
            ]),
          )
        ],
      ),
    );
  }
}

class OwnerCard extends StatelessWidget {
  const OwnerCard({
    super.key,
    required this.owner,
    required this.telNumber,
  });

  final String owner;
  final String telNumber;

  @override
  Widget build(BuildContext context) {
    final Uri phoneNumber = Uri.parse('tel:$telNumber');

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border:
              Border.all(width: 0.5, color: ColorConstants.instance.titleColor),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(owner,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.instance.titleColor,
                    fontFamily: 'Poppins')),
            Text(
              '${'iletisim'.tr()}: $telNumber',
              style: TextStyle(
                  fontSize: 17, color: ColorConstants.instance.commentColor),
            ),
          ]),
          GestureDetector(
            onTap: (() async {
              launchUrl(phoneNumber);
            }),
            child: const Icon(Icons.call, color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class ContainerMiddle extends StatelessWidget {
  const ContainerMiddle({super.key, required this.icon, required this.info});

  final IconData icon;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 0.5, color: ColorConstants.instance.titleColor)),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Wrap(children: [
          Icon(icon, size: 30),
          const SizedBox(width: 5),
          Text(info, style: TextFonts.instance.middleTitle)
        ]),
      ),
    );
  }
}
