import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/app/core/enums.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';
import 'package:take_me_there_app/features/pages/home_page/search_bar_widget.dart';
import 'package:take_me_there_app/map_config/google_maps_dependecy.dart';
import 'package:map_picker/map_picker.dart';

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

    final List<LatLng> driversLocation = [];
    final List<Marker> driversMarkers = [];

    final _pickUpAreaVisible = useState<bool>(false);
    final _pickUpPlaceMark = useState<Placemark?>(null);
    final _pickUpPlaceCoords = useState<GeoPoint?>(null);
    final _customIcon = useState<BitmapDescriptor?>(null);

    CameraPosition cameraPositionP = CameraPosition(
      target: LatLng(
          user.localization?.latitude ?? 0, user.localization?.longitude ?? 0),
      zoom: 14.4746,
    );
    // final LatLng locationOne = LatLng(
    //     user.localization?.latitude ?? 0, user.localization?.longitude ?? 0);
    // final LatLng locationTwo = LatLng(
    //     user.destination?.latitude ?? 0, user.destination?.longitude ?? 0);
    // Future<List<LatLng>> fetchPolylinePoints() async {
    //   final polylinePoints = PolylinePoints();

    //   final result = await polylinePoints.getRouteBetweenCoordinates(
    //     key,
    //     PointLatLng(locationOne.latitude, locationOne.longitude),
    //     PointLatLng(locationTwo.latitude, locationTwo.longitude),

    //     // PointLatLng(locationTwo.latitude, locationTwo.longitude)
    //   );
    //   print("fetch");

    //   return result.points
    //       .map((point) => LatLng(point.latitude, point.longitude))
    //       .toList();
    // }
    final polylinesStateT = useState<Map<PolylineId, Polyline>>({});
    final routePoints = useState<List<LatLng>>([]);
    Future<List<LatLng>> fetchPolylinePoints() async {
      print("GENERATE");
      final points = await ref
          .watch(suggestionControllerProvider.notifier)
          .getRoute(
              userId: user.id,
              start: LatLng(
                  // user.localization!.latitude, user.localization!.longitude
                  _pickUpPlaceCoords.value!.latitude,
                  _pickUpPlaceCoords.value!.longitude),
              end: LatLng(
                  user.destination!.latitude, user.destination!.longitude));
      print("PAGE CAL : $points");
      routePoints.value.addAll(points);
      return points;

      print("PAGE CAL route : ${routePoints.value}");

      // polylinesState.value = Polyline(
      //     polylineId: PolylineId("1"),
      //     width: 5,
      //     color: Colors.yellow,
      //     points: points);

      // polylinesStateT.value = {PolylineId("1"): polylinesState.value!};

      // return Polyline(
      //     polylineId: PolylineId("1"),
      //     width: 5,
      //     color: Colors.yellow,
      //     points: points);
    }

    void generatePolylineFromPoints({required List<LatLng> points}) async {
      final polyline = Polyline(
          polylineId: PolylineId("1"),
          points: points,
          width: 5,
          color: Colors.yellow);
      polylinesStateT.value = {PolylineId("1"): polyline};
    }

    Future<void> initilazeMap() async {
      await fetchPolylinePoints()
          .then((value) => generatePolylineFromPoints(points: value));
    }

    // Future<void> initilazeMap() async {
    //   final points = await fetchPolylinePoints();
    //   generatePolylinesFromPoints(points);
    // }
    ref.listen(userStreamProvider, (previous, next) {
      final previousUser = previous?.value?[0];
      final currentUser = next.value![0];
      if (previousUser?.findRoute != currentUser.findRoute &&
          currentUser.findRoute) {
        fetchPolylinePoints();
        // initilazeMap();
      } else if (previousUser?.settingPickUp != currentUser.settingPickUp &&
          currentUser.settingPickUp) {
        _pickUpAreaVisible.value = true;
      } else if (previousUser?.lookingForDriver !=
              currentUser.lookingForDriver &&
          currentUser.lookingForDriver) {
        _pickUpAreaVisible.value = false;

        initilazeMap();
      }
    });
    useEffect(() {
      // if (user.findRoute) {
      //   initilazeMap();
      // } else {}

      // initilazeMap();
      // ref
      //     .read(locationControllerProvider.notifier)
      //     .updateLocation(userId: user.id);
      // fetchPolylinePoints().then((points) {
      //   if (points.isNotEmpty) {
      //     generatePolylinesFromPoints(points).then((polyline) {
      //       polylinesState.value = {PolylineId("1"): polyline};
      //     });
      //   }
      // });

      return;
    });
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: MapPicker(
            mapPickerController: mapPickerController,
            showDot: _pickUpAreaVisible.value,
            iconWidget: _pickUpAreaVisible.value
                ? SizedBox(
                    height: 60,
                    child: Image(image: AssetImage("assets/person.png")))
                : null,
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
              cameraTargetBounds: _pickUpAreaVisible.value
                  ? CameraTargetBounds(LatLngBounds(
                      southwest: LatLng(user.localization!.latitude - 0.0035,
                          user.localization!.longitude - 0.0045),
                      northeast: LatLng(user.localization!.latitude + 0.0042,
                          user.localization!.longitude + 0.0045)))
                  : CameraTargetBounds.unbounded,
              onCameraMoveStarted: () {
                // notify map is moving
                mapPickerController.mapMoving!();
              },
              onCameraMove: (cameraPosition) {
                cameraPositionP = cameraPosition;
              },
              onCameraIdle: () async {
                mapPickerController.mapFinishedMoving!();
                //get address name from camera position
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPositionP.target.latitude,
                  cameraPositionP.target.longitude,
                );

                _pickUpPlaceMark.value = placemarks[0];
                print("${placemarks}   ");
                _pickUpPlaceCoords.value = GeoPoint(
                    cameraPositionP.target.latitude,
                    cameraPositionP.target.longitude);

                print("COORDS  ${cameraPositionP.target}");

                // update the ui with the address
              },
              circles: {
                Circle(
                    visible: _pickUpAreaVisible.value,
                    circleId: CircleId("1"),
                    center: LatLng(user.localization!.latitude,
                        user.localization!.longitude),
                    radius: 420,
                    strokeWidth: 1,
                    strokeColor: Colors.white,
                    fillColor: Color.fromARGB(23, 255, 235, 59))
              },
              markers: {
                // Marker(
                //     markerId: MarkerId("value1"),
                //     icon: BitmapDescriptor.defaultMarker,
                //     position: LatLng(user.localization!.latitude,
                //         user.localization!.longitude)),
                Marker(
                  visible: user.lookingForDriver,
                  markerId: MarkerId("pickUp"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: LatLng(user.localization!.latitude,
                      user.localization!.longitude),
                ),
                Marker(
                    visible: user.lookingForDriver,
                    markerId: MarkerId("destination"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: LatLng(user.destination!.latitude,
                        user.destination!.longitude)),

                for (final marker in driversMarkers) ...{marker}
              },
              polylines: user.lookingForDriver == false
                  ? Set()
                  : Set<Polyline>.of(polylinesStateT.value.values),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: SearchBarWidget(
              GeoPoint(_pickUpPlaceCoords.value?.latitude ?? 0,
                  _pickUpPlaceCoords.value?.longitude ?? 0),
              _pickUpPlaceMark.value,
              user.distance,
              user.id,
              user),
        )
      ]),
    );
  }
}
