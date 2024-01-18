import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_number_2/utils/colors.dart' as app_color;
import 'package:flutter_number_2/utils/images.dart' as app_img;
import 'package:flutter_number_2/utils/typography.dart' as app_typo;

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  State<MainMap> createState() => MainMapState();
}

class MainMapState extends State<MainMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LocationData? currentLocation;

  late final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
    ),
    zoom: 14,
  );

  Future<void> getCurrentLocation() async {
    Location location = Location();

    await location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 14,
            target: LatLng(newLoc.latitude!, newLoc.longitude!),
          ),
        ),
      );

      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator(color: app_color.primary))
          : GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: app_color.secondary,
        onPressed: shareLocation,
        label: Text(
          'Share your location!',
          style: app_typo.labelText
              .copyWith(color: app_color.primary, fontWeight: FontWeight.w700),
        ),
        icon: const Icon(
          Icons.location_on,
          color: app_color.primary,
        ),
      ),
    );
  }

  Future<void> shareLocation() async {}
}
