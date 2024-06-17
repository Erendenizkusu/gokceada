import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core/colors.dart';
import '../../core/textFont.dart';
import '../../product/card_design.dart';
import '../../product/hotelListCard.dart';
import '../screens/navBar.dart';
import '../screens/restaurantDetail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    initBannerAd();
  }

  late BannerAd bannerAd;
  bool isAddLoaded = false;
  var adUnit = "ca-app-pub-3940256099942544/9214589741"; //testing ad id

  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adUnit,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            isAddLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error);
        }),
        request: const AdRequest());

    bannerAd.load();
  }

  List<ImageCardDesign> gokceadaPhotos = [
    const ImageCardDesign(image: 'images/gokceadaDirectory/gokceada.jpg'),
    const ImageCardDesign(image: 'images/gokceadaDirectory/gokceada1.jpg'),
    const ImageCardDesign(image: 'images/gokceadaDirectory/gokceada2.jpg'),
    const ImageCardDesign(image: 'images/gokceadaDirectory/gokceada3.jpg'),
    const ImageCardDesign(image: 'images/gokceadaDirectory/gokceada4.jpg'),
    const ImageCardDesign(image: 'images/gokceadaDirectory/gokceada5.jpg'),
    const ImageCardDesign(image: 'images/gokceadaDirectory/gokceada6.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    List<CardDesign> items = [
      CardDesign(
          path: 'images/otel.jpg',
          cardText: 'oteller'.tr(),
          pushWhere: 'oteller'),
      CardDesign(
          path: 'images/pansiyon.jpg',
          cardText: 'pansionlar'.tr(),
          pushWhere: 'pansionList'),
      CardDesign(
          path: 'images/restourant.jpg',
          cardText: 'restoranlar'.tr(),
          pushWhere: 'restaurantsView'),
      CardDesign(
          path: 'images/kamp_alanları.jpg',
          cardText: 'kampalanlari'.tr(),
          pushWhere: 'camping'),
      CardDesign(
          path: 'images/yildizkoy/yildizkoy.jpg',
          cardText: 'plajlar'.tr(),
          pushWhere: 'plajlar'),
      CardDesign(
          path: 'images/surfing.jpg',
          cardText: 'surfOkullari'.tr(),
          pushWhere: 'surfing'),
    ];
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('Gökçeada', style: TextFonts.instance.appBarTitle),
          centerTitle: true,
          backgroundColor: ColorConstants.instance.titleColor),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(children: <Widget>[
          const SizedBox(height: 15),
          SizedBox(
            height: 200,
            child: PageView(controller: controller, children: items),
          ),
          Center(child: Indicator(controller: controller, list: items)),
          Wrap(
            spacing: 6,
            children: [
              CustomTextButton(text: 'gormeyeDeger'.tr(), route: 'gezilecek'),
              CustomTextButton(text: 'neredeYenir'.tr(), route: 'foodareas'),
              CustomTextButton(text: 'atm'.tr(), route: 'atm'),
              CustomTextButton(text: 'aktiviteler'.tr(), route: 'activities'),
              CustomTextButton(text: 'koyler'.tr(), route: 'villages'),
              CustomTextButton(text: 'feribotSaatleri'.tr(), route: 'fery'),
            ],
          ),
          Divider(
              thickness: 2,
              height: 5,
              color: ColorConstants.instance.titleColor),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CircularImagesTop(list: gokceadaPhotos),
          ),
          Text('tarihce'.tr(), style: TextFonts.instance.middleTitle),
          const SizedBox(height: 10),
          Text(
            'gokceadaTarihcesi'.tr(),
            style: TextFonts.instance.commentTextBold,
          )
        ]),
      ),
      bottomNavigationBar: isAddLoaded
          ? SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: AdWidget(ad: bannerAd),
            )
          : const SizedBox(),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.route,
  }) : super(key: key);

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/$route');
      },
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor:
              WidgetStateProperty.all(ColorConstants.instance.titleColor)),
    );
  }
}
