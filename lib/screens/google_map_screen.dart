import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab3_193059/model/list_item.dart';
import 'package:lab3_193059/services/notifications.dart';

//42.00478491557928, 21.40917442067392
//AIzaSyCTU44OdPCCKty20mcL3vl-hMJ4GIBLHaQ

class GoogleMapPage extends StatefulWidget {
  static const String id = "mapScreen";
  final List<ListKolokviumi> _list;
  GoogleMapPage(this._list);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState(_list);
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  final NotificationService service = NotificationService();
  final List<Marker> markers = <Marker>[];
  List<ListKolokviumi> _list;
  Completer<GoogleMapController> _controller = Completer();

  _GoogleMapPageState(this._list);

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(42.00478491557928, 21.40917442067392),
    zoom: 14.4746,
  );

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _createMarkers(_list);
  }

  void _createMarkers(_list) {
    for (var i = 0; i < _list.length; i++) {
      print(_list[i].imeNaPredmet);
      markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position:
            LatLng(_list[i].lokacija.latitude, _list[i].lokacija.longitude),
        infoWindow: InfoWindow(
          //popup info
          title: _list[i].imeNaPredmet,
          snippet:
              DateFormat("yyyy-MM-dd HH:mm:ss").format(_list[i].datumVreme),
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9D6B0F),
        title: Text("Google Map Page"),
      ),
      body: Container(
        child: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _kGoogle,
            markers: Set<Marker>.of(markers),
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() + " " + value.longitude.toString());

            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 14,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: Icon(Icons.pin_drop_outlined),
      ),
    );
  }
}
