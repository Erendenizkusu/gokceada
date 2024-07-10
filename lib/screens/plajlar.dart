import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gokceada/core/colors.dart';
import 'package:gokceada/core/textFont.dart';
import 'package:gokceada/screens/plajlarMap.dart';


class PlajlarView extends StatefulWidget {
  const PlajlarView({super.key});

  @override
  State<PlajlarView> createState() => _PlajlarViewState();
}

class _PlajlarViewState extends State<PlajlarView> {
  final List<PlajCard> _plajList = [
    const PlajCard(path: 'images/yildizkoy/yildizkoy2.jpg', name: 'Yıldızkoy', description: 'Türkiye\'nin ilk ve tek su altı milli parkı',navigator: 'yildizkoy'),
    const PlajCard(path: 'images/kefalos/kefalos1.jpg', name: 'Kefalos', description: 'İnce kum taneleri, berrak deniz ve surfing alanları',navigator: 'kefalos'),
    const PlajCard(path: 'images/lazkoyu/lazkoyu.jpg', name: 'Laz Koyu', description: 'Güney kıyısında ufak bir kumsal koy',navigator: 'lazkoyu'),
    const PlajCard(path: 'images/gizliliman/gizliliman.jpg', name: 'Gizli Liman', description: 'Ada\'nın en batı ucu ve mağara',navigator: 'gizliliman'),
    const PlajCard(path: 'images/kuzulimani/kuzulimanı1.jpg', name: 'Kuzu Limanı', description: 'Feribotun yanaştığı limanın yanında geniş,kumluk bir plaj',navigator: 'kuzulimanı'),
    const PlajCard(path: 'images/marmaros/marmaros.jpg', name: 'Marmaros', description: 'Orman\'ın derinliklerinde sizi karşılayan taşlık bir koy',navigator: 'marmaros'),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: Text('plajlar'.tr(),style: TextFonts.instance.middleTitle),
          leading: Builder(builder: (context) {
            return IconButton(onPressed: (){}, icon: BackButton(color: ColorConstants.instance.titleColor,));
          },),
          backgroundColor: const Color(0xffffc38c),
          elevation: 0),
          body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffffc38c),Colors.cyanAccent], // İstenilen renk geçişi burada tanımlanır
          ),
          ),
          child:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ListView.builder(
            itemCount: _plajList.length,
            itemBuilder: (context,index){
              return PlajCard(path: _plajList[index].path,name: _plajList[index].name,description: _plajList[index].description,navigator: _plajList[index].navigator);
            }),
          ),
        ),
    );
  }
}

class PlajCard extends StatelessWidget {
    const PlajCard({
    super.key,required this.path,required this.name,required this.description,required this.navigator
  });

  final String path;
  final String name;
  final String description;
  final String navigator;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => plajlar(context)[navigator] as Widget,
          ));
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.7,
            color: ColorConstants.instance.titleColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        height: 300,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              height: 200,
              width: double.infinity,
              child: Image.asset(path, fit: BoxFit.fill),
            ),
            Expanded(
              child:Container(
              padding: const EdgeInsets.all(9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextFonts.instance.middleTitle),
                  Expanded( child:Text(
                    description,
                    style: const TextStyle(fontSize: 15,color: Colors.black),
                    maxLines: 2,
                  ),
                  )],
              ),
            ),
            )],
        ),
      ),
    );
  }
}

