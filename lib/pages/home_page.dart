import 'package:flutter/material.dart';
import 'package:gokceada/product/languageButton.dart';
import '../../core/colors.dart';
import '../../core/textFont.dart';
import '../../product/card_design.dart';
import '../../product/hotelListCard.dart';
import '../screens/navBar.dart';
import '../screens/restaurantDetail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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

    PageController _controller = PageController();
    List<CardDesign> items =[
      CardDesign(path: 'images/otel.jpg',cardText: AppLocalizations.of(context).oteller,pushWhere: 'oteller'),
      CardDesign(path: 'images/pansiyon.jpg',cardText: AppLocalizations.of(context).pansionlar,pushWhere: 'pansionList'),
      CardDesign(path: 'images/restourant.jpg',cardText: AppLocalizations.of(context).restoranlar,pushWhere: 'restaurantsView'),
      CardDesign(path: 'images/kamp_alanları.jpg',cardText: AppLocalizations.of(context).kampalanlari,pushWhere: 'camping'),
      CardDesign(path: 'images/yildizkoy/yildizkoy.jpg',cardText: AppLocalizations.of(context).plajlar,pushWhere: 'plajlar'),
      CardDesign(path: 'images/surfing.jpg',cardText: AppLocalizations.of(context).surfOkullari,pushWhere: 'surfing'),
    ];
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: Center(child: Text('Gökçeada',style: TextFonts.instance.appBarTitle)),
        actions: const [LanguageButton(),SizedBox(width: 15)],
          backgroundColor: ColorConstants.instance.titleColor),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
            children: <Widget>[
              const SizedBox(height: 15),
              SizedBox(
                height: 200,
                child: PageView(
                    controller: _controller,
                    children: items),
              ),
              Center(child: Indicator(controller: _controller, list: items)),
               Wrap(
                spacing: 6,
                children: [
                  CustomTextButton(text: AppLocalizations.of(context).gormeyeDeger,route: 'gezilecek'),
                  CustomTextButton(text: AppLocalizations.of(context).neredeYenir,route: 'foodareas'),
                  CustomTextButton(text: AppLocalizations.of(context).atm,route: 'atm'),
                  CustomTextButton(text: AppLocalizations.of(context).aktiviteler,route: 'activities'),
                  CustomTextButton(text: AppLocalizations.of(context).koyler,route: 'villages'),
                  CustomTextButton(text: AppLocalizations.of(context).feribotSaatleri,route: 'fery'),
                ],),
              Divider(thickness: 2,height: 5,color: ColorConstants.instance.titleColor),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CircularImagesTop(list: gokceadaPhotos),
              ),
              Text(AppLocalizations.of(context).tarihce,style: TextFonts.instance.middleTitle),
              const SizedBox(height: 10),
              Text(AppLocalizations.of(context).gokceadaTarihcesi,style: TextFonts.instance.commentTextBold,)
            ]),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key, required this.text, required this.route,
  }) : super(key: key);

  final String text;
  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        Navigator.pushNamed(context, '/$route');
      },
      child: Text(text,style: const TextStyle(fontWeight: FontWeight.w500),),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(ColorConstants.instance.titleColor)),
    );
  }
}
