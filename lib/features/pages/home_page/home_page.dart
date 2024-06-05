import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';
import 'package:take_me_there_app/map_config/google_maps_dependecy.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
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

  final LatLng locationOne = LatLng(37.42796133580664, -122.085749655962);
  final LatLng locationTwo = LatLng(37.43296265331129, -122.08832357078792);
  Map<PolylineId, Polyline> polylines = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStreamProvider).value![0];
    final LatLng locationOne =
        LatLng(user.geoPoint!.latitude, user.geoPoint!.longitude);
    final LatLng locationTwo = LatLng(38.43296265331129, -121.08832357078792);
    Future<List<LatLng>> fetchPolylinePoints() async {
      final polylinePoints = PolylinePoints();
      final result = await polylinePoints.getRouteBetweenCoordinates(
          key,
          PointLatLng(user.geoPoint!.latitude, user.geoPoint!.longitude),
          PointLatLng(locationTwo.latitude, locationTwo.longitude));

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
      ref
          .read(locationControllerProvider.notifier)
          .updateLocation(userId: user.id);
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
      body: Stack(children: [
        Expanded(
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
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: SearchBarWidget(),
        )
      ]),
    );
  }
}

class SearchBarWidget extends HookConsumerWidget {
  SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickUpLocationController = useTextEditingController();
    final destinationController = useTextEditingController();
    final widgetContetController = useState(0);
    final _areFieldsEmpty = useState<bool>(true);

    bool areFieldsEmpty() {
      return pickUpLocationController.text.toString().isEmpty ||
          destinationController.text.toString().isEmpty;
    }

    useEffect(() {
      pickUpLocationController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      destinationController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      return;
    });

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          color: Color.fromARGB(173, 0, 0, 0),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08,
          vertical: MediaQuery.of(context).size.width * 0.025),
      child: ListView(
        children: [
          widgetContetController.value == 1
              ? Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        widgetContetController.value = 0;
                      },
                      icon: Icon(Icons.arrow_back)),
                )
              : SizedBox.shrink(),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                if (widgetContetController.value == 0) ...[
                  Column(
                    children: [
                      TextField(
                        controller: pickUpLocationController,
                        decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            hintText: "Where would you like to be picked up?"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextField(
                          controller: destinationController,
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(),
                              hintText: "Where would you like to be taken?")),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 60, right: 60),
                        child: (ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blueAccent,
                          ),
                          onPressed: _areFieldsEmpty.value
                              ? null
                              : () {
                                  widgetContetController.value = 1;
                                  pickUpLocationController.clear();
                                  destinationController.clear();
                                },
                          child: Text("Take me there"),
                        )),
                      ),
                    ],
                  ),
                ] else ...[
                  Column(
                    children: [
                      Text("Service type 1 "),
                      Text("Service type 2 "),
                      Text("Service type 3 "),
                      Text("Service type 4 "),
                      Text("Service type 5 "),
                      Text("Service type 6 "),
                      Text("Service type 7 "),
                      Text("Service type 8 "),
                      Text("Service type 9 "),
                      Text("Service type 10 "),
                    ],
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
