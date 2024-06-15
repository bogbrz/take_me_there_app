import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_picker/map_picker.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';
import 'package:take_me_there_app/features/pages/home_page/search_bar_widget.dart';

import 'package:take_me_there_app/map_config/google_maps_dependecy.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';
import 'package:take_me_there_app/providers/google_places_provider.dart';

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  MapPickerController mapPickerController = MapPickerController();
  Position? currentPositionOfUser;
  void updateMapTheme(GoogleMapController mapController) {
    getJsonFileFromThemes(mapThemePath: "themes/dark_theme.json").then(
        (value) =>
            setMapTheme(googleMapTheme: value, mapController: mapController));
  }

  Future<String> getJsonFileFromThemes({required String mapThemePath}) async {
    // We get Theme from here
    ByteData byteData = await rootBundle.load(mapThemePath);
    var list = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  setMapTheme(
      {required String googleMapTheme,
      required GoogleMapController mapController}) {
    mapController.setMapStyle(googleMapTheme);
  }

  getCurrentLiveLocationOfUser() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position postionOfUser = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositionOfUser = postionOfUser;
    LatLng positionOfUserInLatLng = LatLng(
        currentPositionOfUser!.latitude, currentPositionOfUser!.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: positionOfUserInLatLng, zoom: 15);
    controllerGoogleMap!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // final LatLng locationOne = LatLng(37.42796133580664, -122.085749655962);
  // final LatLng locationTwo = LatLng(37.43296265331129, -122.08832357078792);
  Map<PolylineId, Polyline> polylines = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStreamProvider).value![0];
    final LatLng locationOne =
        LatLng(user.geoPoint!.latitude, user.geoPoint!.longitude);
    CameraPosition cameraPosition = const CameraPosition(
      target: LatLng(41.311158, 69.279737),
      zoom: 14.4746,
    );
    final LatLng locationTwo = LatLng(37.43296265331129, -122.08832357078792);
    Future<List<LatLng>> fetchPolylinePoints() async {
      final polylinePoints = PolylinePoints();
      final result = await polylinePoints.getRouteBetweenCoordinates(
        key,
        PointLatLng(locationOne.latitude, locationOne.longitude),
        PointLatLng(user.geoPoint!.latitude, user.geoPoint!.longitude),
        // PointLatLng(locationTwo.latitude, locationTwo.longitude)
      );

      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    }

    Future<Polyline> generatePolylinesFromPoints(
        List<LatLng> polylineCoordinates) async {
      return Polyline(
          polylineId: PolylineId("1"),
          width: 5,
          color: Colors.yellow,
          points: polylineCoordinates);
    }

    // Future<void> initilazeMap() async {
    //   final points = await fetchPolylinePoints();
    //   generatePolylinesFromPoints(points);
    // }
    Future<void> initilazeMap() async {
      final points = await fetchPolylinePoints();
      generatePolylinesFromPoints(points);
    }

    final polylinesState = useState<Map<PolylineId, Polyline>>({});
    useEffect(() {
      // ref
      //     .read(locationControllerProvider.notifier)
      //     .updateLocation(userId: user.id);
      fetchPolylinePoints().then((points) {
        if (points.isNotEmpty) {
          generatePolylinesFromPoints(points).then((polyline) {
            polylinesState.value = {PolylineId("1"): polyline};
          });
        }
      });

      return;
    });
    return Scaffold(
      body: user.geoPoint == null
          ? Center(child: CircularProgressIndicator())
          : Stack(children: [
              Positioned.fill(
                child: MapPicker(
                  iconWidget: Image(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                    image: AssetImage("assets/hatchback.png"),
                  ),
                  mapPickerController: mapPickerController,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: googlePlexInitialPosition,
                    zoomControlsEnabled: true,
                    onMapCreated: (controller) {
                      controllerGoogleMap = controller;
                      updateMapTheme(controller);
                      _controller.complete(controllerGoogleMap);
                      getCurrentLiveLocationOfUser();
                    },
                    onCameraIdle: () async {
                      // notify map stopped moving
                      mapPickerController.mapFinishedMoving!();
                      //get address name from camera position
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                        cameraPosition.target.latitude,
                        cameraPosition.target.longitude,
                      );
                      print(placemarks);

                      // update the ui with the address
                    },
                    markers: {
                      Marker(
                          markerId: MarkerId("value1"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: locationOne),
                      Marker(
                          markerId: MarkerId("value2"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: locationTwo),
                    },
                    polylines: Set<Polyline>.of(polylinesState.value.values),
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: SearchBarWidget(user.id),
              )
            ]),
    );
  }
}
