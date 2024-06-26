import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/services/google_ads.dart';
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
  final GoogleAds _googleAds = GoogleAds();


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
  void initState() {
    _googleAds.loadBannerAd();
    super.initState();
  }

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
              CustomTextButton(text: 'neredeYenir'.tr(), route: 'foodareas',isAd: true),
              CustomTextButton(text: 'atm'.tr(), route: 'atm'),
              CustomTextButton(text: 'aktiviteler'.tr(), route: 'activities'),
              CustomTextButton(text: 'otobusSaatleri'.tr(), route: 'bus',isAd: true),
              CustomTextButton(text: 'feribotSaatleri'.tr(), route: 'fery',isAd: true),
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
      bottomNavigationBar: _googleAds.bannerAd != null ?
      SizedBox(
        height: _googleAds.bannerAd?.size.height.toDouble(),
        width: MediaQuery.of(context).size.width,
        child: AdWidget(ad: _googleAds.bannerAd!),
      ) : const SizedBox(),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final GoogleAds _googleAds = GoogleAds();
  CustomTextButton({
    super.key,
    required this.text,
    required this.route, this.isAd = false,
  });

  final String text;
  final String route;
  final bool isAd;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        isAd ? _googleAds.loadInterstitialAd() : null;
        Navigator.pushNamed(context, '/$route');
      },
      style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor:
          WidgetStateProperty.all(ColorConstants.instance.titleColor)),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}