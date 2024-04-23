import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:url_launcher/url_launcher.dart';
import '../product/hotelListCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../product/navigationButton.dart';

class HotelRoomsView extends StatefulWidget {
  const HotelRoomsView(
      {Key? key,
      required this.list,
      required this.description,
      required this.location,
      required this.hotelName,
      required this.facilities,
      required this.owner,
      required this.latitude,
      required this.longitude,
      required this.telNo})
      : super(key: key);
  final List<String> list;
  final double latitude;
  final double longitude;
  final String hotelName;
  final String description;
  final String location;
  final List<ContainerMiddle> facilities;
  final String owner;
  final String telNo;

  @override
  State<HotelRoomsView> createState() => _HotelRoomsViewState();
}

class _HotelRoomsViewState extends State<HotelRoomsView> {
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
      body: ListView(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: (MediaQuery.of(context).size.height) * 0.35,
            child: PageView(controller: _controller, children: images),
          ),
          Center(child: Indicator(controller: _controller, list: images)),
          const SizedBox(height: 10),
          Center(
            child: NavigationButton(latitude: widget.latitude,longitude: widget.longitude),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 350,
                    child: Text(widget.hotelName,
                        style: TextFonts.instance.titleFont),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(widget.location, style: TextFonts.instance.commentTextThin),
              const SizedBox(height: 20),
              Text(AppLocalizations.of(context).tesisOzellikleri,
                  style: TextFonts.instance.middleTitle),
              const SizedBox(height: 20),
              Text(
                widget.description,
                style: TextFonts.instance.commentTextBold,
              ),
              const SizedBox(height: 40),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(AppLocalizations.of(context).odaOzellikleri,
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
    Key? key,
    required this.owner,
    required this.telNumber,
  }) : super(key: key);

  final String owner;
  final String telNumber;

  @override
  Widget build(BuildContext context) {
    final Uri phoneNumber = Uri.parse('tel:$telNumber');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 0.5, color: ColorConstants.instance.titleColor),
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
                  '${AppLocalizations.of(context).iletisim}: $telNumber',
                  style: TextStyle(
                      fontSize: 17,
                      color: ColorConstants.instance.commentColor),
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
        ),
      ],
    );
  }
}

class ContainerMiddle extends StatelessWidget {
  const ContainerMiddle({Key? key, required this.icon, required this.info})
      : super(key: key);
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
