import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';


class NavigationPage extends StatefulWidget {
  final LatLng sourceLocation;

  const NavigationPage({Key? key, required this.sourceLocation}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  LatLng? destinationLocation;

  @override
  void initState() {
    super.initState();
    getCurrentUserLocation();
  }

  Future<void> showPermissionDeniedDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konum İzinleri'),
          content: const Text('Konum iznini etkinleştirmeniz gerekiyor.'),
          actions: [
            TextButton(
              child: const Text('Ayarlar'),
              onPressed: () {
                AppSettings.openAppSettings();
              },
            ),
            TextButton(
              child: const Text('İptal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getCurrentUserLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        await showPermissionDeniedDialog(context);
      }
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          destinationLocation = LatLng(position.latitude, position.longitude);
        });
      }
    } else {
      await showPermissionDeniedDialog(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.sourceLocation,
          zoom: 14.0,
        ),
        markers: <Marker>{
          Marker(
            markerId: const MarkerId('source'),
            position: widget.sourceLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: const InfoWindow(title: 'Source'),
          ),
          Marker(
            markerId: const MarkerId('destination'),
            position: destinationLocation ?? widget.sourceLocation,
            infoWindow: const InfoWindow(title: 'Destination'),
          ),
        },
      ),
    );
  }
}

class NavigationInkwell extends StatelessWidget {
  const NavigationInkwell({Key? key, required this.latitude, required this.longitude, required this.widget}) : super(key: key);
  final double latitude;
  final double longitude;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget,
      onTap: (){
    LatLng sourceLocation =  LatLng(latitude, longitude);
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => NavigationPage(sourceLocation: sourceLocation),
    ),
    );
    },
    );
  }
}
