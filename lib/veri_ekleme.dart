import 'package:cloud_firestore/cloud_firestore.dart';

// Firestore koleksiyonuna belge ekleme fonksiyonu
void addDocument() {
  var data = {
    'image': [''],
    'location': '',
    'rating': '',
    'restaurant_name': '',
    'telNo': '',
    'link': '',
    'latLng': [],
  };

  FirebaseFirestore.instance
      .collection('restaurantList')
      .add(data)
      .then((docRef) {
    print('Belge başarıyla oluşturuldu: ${docRef.id}');
  })
      .catchError((error) {
    print('Hata oluştu: $error');
  });
}
