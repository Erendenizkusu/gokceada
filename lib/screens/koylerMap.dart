import 'package:flutter/material.dart';
import 'package:gokceada/product/plaj_inside_design.dart';
import 'package:gokceada/screens/restaurantDetail.dart';
import '../product/navigationButton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Map<String,Widget> createKoyler(BuildContext context) {
  return {
    'bademli': DescriptionCustom(
        title: 'Bademli - Gliki',
        images: const [
          ImageCardDesign(image: 'images/bademli/bademli.jpg'),
          ImageCardDesign(image: 'images/bademli/bademli1.jpg'),
          ImageCardDesign(image: 'images/bademli/bademli2.jpg'),
          ImageCardDesign(image: 'images/bademli/bademli3.jpg'),
          ImageCardDesign(image: 'images/bademli/bademli4.jpg'),
          ImageCardDesign(image: 'images/bademli/bademli5.jpg'),
          ImageCardDesign(image: 'images/bademli/bademli6.jpg'),
          ImageCardDesign(image: 'images/bademli/bademli7.jpg'),
          ImageCardDesign(image: 'images/bademli/bademli8.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.22132946119443, longitude: 25.90695936121934),
        description: AppLocalizations
            .of(context)
            .bademli),

    'derekoy': DescriptionCustom(
        title: 'Dereköy',
        images: const [
          ImageCardDesign(image: 'images/derekoy/derekoy.jpg'),
          ImageCardDesign(image: 'images/derekoy/derekoy1.jpg'),
          ImageCardDesign(image: 'images/derekoy/derekoy2.jpg'),
          ImageCardDesign(image: 'images/derekoy/derekoy3.jpg'),
          ImageCardDesign(image: 'images/derekoy/derekoy4.jpg'),
          ImageCardDesign(image: 'images/derekoy/derekoy5.jpg'),
          ImageCardDesign(image: 'images/derekoy/derekoy6.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.156565879596876, longitude: 25.779833059383733),
        description: AppLocalizations
            .of(context)
            .derekoy),

    'eselek': DescriptionCustom(
        title: 'Eşelek Köyü',
        images: const [
          ImageCardDesign(image: 'images/eselek/eselek.jpg'),
          ImageCardDesign(image: 'images/eselek/eselek1.jpg'),
          ImageCardDesign(image: 'images/eselek/eselek2.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.14759580493827, longitude: 25.94710513716375),
        description: AppLocalizations.of(context).eselek),

    'kalekoy': DescriptionCustom(
        title: 'Kaleköy - Kastro',
        images: const [
          ImageCardDesign(image: 'images/kalekoy/kalekoy.jpg'),
          ImageCardDesign(image: 'images/kalekoy/kalekoy1.jpg'),
          ImageCardDesign(image: 'images/kalekoy/kalekoy2.jpg'),
          ImageCardDesign(image: 'images/kalekoy/kalekoy3.jpg'),
          ImageCardDesign(image: 'images/kalekoy/kalekoy4.jpg'),
          ImageCardDesign(image: 'images/kalekoy/kalekoy5.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.234366399996055, longitude: 25.89884971836279),
        description: AppLocalizations.of(context).kalekoy),

    'kalekoyLiman': DescriptionCustom(
        title: 'Kaleköy Liman',
        images: const [
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman.jpg'),
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman1.jpg'),
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman2.jpg'),
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman3.jpg'),
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman4.jpg'),
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman5.jpg'),
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman6.jpg'),
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman7.jpg'),
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman8.jpg'),
          ImageCardDesign(image: 'images/kalekoyliman/kalekoyliman9.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.23136718323504, longitude: 25.894804669123182),
        description: AppLocalizations.of(context).kalekoyLiman),


    'merkez': DescriptionCustom(
        title: 'Ada Merkezi',
        images: const [
          ImageCardDesign(image: 'images/merkez/merkez.jpg'),
          ImageCardDesign(image: 'images/merkez/merkez1.jpg'),
          ImageCardDesign(image: 'images/merkez/merkez2.jpg'),
          ImageCardDesign(image: 'images/merkez/merkez3.jpg'),
          ImageCardDesign(image: 'images/merkez/merkez4.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.19624748335972, longitude: 25.90766888323214),
        description: AppLocalizations.of(context).merkez),

    'sahinkaya': DescriptionCustom(
        title: 'Şahinkaya Köyü',
        images: const [
          ImageCardDesign(image: 'images/sahinkaya/sahinkaya.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.150813785785985, longitude: 25.785779654393263),
        description: AppLocalizations.of(context).sahinkaya),

    'sirinkoy': DescriptionCustom(
        title: 'Şirinköy',
        images: const [
          ImageCardDesign(image: 'images/sirinkoy/sirinkoy.jpg'),
          ImageCardDesign(image: 'images/sirinkoy/sirinkoy1.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.1286817177055, longitude: 25.74225144997795),
        description: AppLocalizations.of(context).sirinkoy),

    'tepekoy': DescriptionCustom(
        title: 'Tepeköy - Agridia',
        images: const [
          ImageCardDesign(image: 'images/tepekoy/tepekoy.jpg'),
          ImageCardDesign(image: 'images/tepekoy/tepekoy1.jpg'),
          ImageCardDesign(image: 'images/tepekoy/tepekoy2.jpg'),
          ImageCardDesign(image: 'images/tepekoy/tepekoy3.jpg'),
          ImageCardDesign(image: 'images/tepekoy/tepekoy4.jpg'),
          ImageCardDesign(image: 'images/tepekoy/tepekoy5.jpg'),
          ImageCardDesign(image: 'images/tepekoy/tepekoy6.jpg'),
          ImageCardDesign(image: 'images/tepekoy/tepekoy7.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.14860030447957, longitude: 25.776397678636698),
        description: AppLocalizations.of(context).tepekoy),

    'ugurlu': DescriptionCustom(
        title: 'Uğurlu Köyü',
        images: const [
          ImageCardDesign(image: 'images/ugurlu/ugurlu.jpg'),
          ImageCardDesign(image: 'images/ugurlu/ugurlu1.jpg'),
          ImageCardDesign(image: 'images/ugurlu/ugurlu2.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.12373775008842, longitude: 25.70627252370199),
        description: AppLocalizations.of(context).ugurlu),

    'yenibademli': DescriptionCustom(
        title: 'Yenibademli',
        images: const [
          ImageCardDesign(image: 'images/yenibademli/yenibademli.jpg'),
          ImageCardDesign(image: 'images/yenibademli/yenibademli1.jpg'),
          ImageCardDesign(image: 'images/yenibademli/yenibademli2.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.229279376684836, longitude: 25.906215449547606),
        description: AppLocalizations.of(context).yenibademli),

    'zeytinlikoy': DescriptionCustom(
        title: 'Zeytinliköy - Aya Teodoroi',
        images: const [
          ImageCardDesign(image: 'images/zeytinli/zeytinli.jpg'),
          ImageCardDesign(image: 'images/zeytinli/zeytinli1.jpg'),
          ImageCardDesign(image: 'images/zeytinli/zeytinli2.jpg'),
          ImageCardDesign(image: 'images/zeytinli/zeytinli3.jpg'),
          ImageCardDesign(image: 'images/zeytinli/zeytinli4.jpg'),
          ImageCardDesign(image: 'images/zeytinli/zeytinli5.jpg'),
        ],
        widget: const NavigationButton(
            latitude: 40.19042836024782, longitude: 25.871124776652493),
        description: AppLocalizations.of(context).zeytinlikoy)
  };
}


