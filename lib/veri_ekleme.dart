import 'package:cloud_firestore/cloud_firestore.dart';

// Firestore koleksiyonuna belge ekleme fonksiyonu
void addDocument() {
  var data = {
    'image': [''],
    'location': '',
    'rating': '',
    'hotel_name': '',
    'icon': [''],
    'info': [''],
    'description': '',
    'owner': '',
    'telNo': '',
    'latLng': [],
  };

  FirebaseFirestore.instance
      .collection('hotelList')
      .add(data)
      .then((docRef) {
    print('Belge başarıyla oluşturuldu: ${docRef.id}');
  })
      .catchError((error) {
    print('Hata oluştu: $error');
  });
}
