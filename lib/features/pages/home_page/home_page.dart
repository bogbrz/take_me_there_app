import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_picker/map_picker.dart';
import 'package:take_me_there_app/app/core/device_size.dart';
import 'package:take_me_there_app/app/core/enums.dart';
import 'package:take_me_there_app/domain/models/ride_model.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';
import 'package:take_me_there_app/features/pages/home_page/widgets/bottom_panel.dart';
import 'package:take_me_there_app/features/pages/home_page/widgets/top_panel.dart';
import 'package:take_me_there_app/map_config/google_maps_dependecy.dart';
import 'package:take_me_there_app/providers/is_writing_provider.dart';

class HomePage extends HookConsumerWidget {
  HomePage({super.key});

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GoogleMapController? controllerGoogleMap;
  MapPickerController mapPickerController = MapPickerController();
  // final PanelController bottomPanelController = PanelController();
  // final PanelController topPanelController = PanelController();
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

  Map<PolylineId, Polyline> polylines = {};

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = DeviceSize(context).height;
    double width = DeviceSize(context).width;
    final user = ref.watch(userStreamProvider).value![0];
    final drivers = ref.watch(driverUsersStreamProvider).value ?? [];
    final isWriting = ref.watch(isWritingProvider);
    final bottomPanelController = ref.watch(bottomPanelControllerProvider);
    final topPanelController = ref.watch(topPanelControllerProvider);
    final isTyping = ref.watch(isTypingProvider);
    final textController = ref.watch(destinationTextControllerProvider);
    final keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    // final clients = ref.watch(clientUsersStreamProvider).value ?? [];

    final List<Marker> driversMarkers = drivers
        .map((e) => Marker(
            markerId: MarkerId("${e.id}"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(
                e.localization?.latitude ?? 0, e.localization?.longitude ?? 0)))
        .toList();
    // final List<Marker> clientsMarkers = clients
    //     .map((e) => Marker(
    //         markerId: MarkerId("${e.id}"),
    //         icon: BitmapDescriptor.defaultMarker,
    //         position: LatLng(
    //             e.localization?.latitude ?? 0, e.localization?.longitude ?? 0)))
    //     .toList();
    final _pickUpAreaVisible = useState<bool>(false);
    final _pickUpPlaceMark = useState<Placemark?>(null);
    final _pickUpPlaceCoords = useState<GeoPoint?>(null);

    CameraPosition cameraPositionP = CameraPosition(
      target: LatLng(
          user.localization?.latitude ?? 0, user.localization?.longitude ?? 0),
      zoom: 14.4746,
    );

    final polylinesStateT = useState<Map<PolylineId, Polyline>>({});

    Future<List<LatLng>> fetchPointsForDriversRoute(
        {required RideModel ride}) async {
      final driversRoutePoints = await ref
          .watch(suggestionControllerProvider.notifier)
          .getDriverRoute(
            start: LatLng(
                ride.driverLocation!.latitude, ride.driverLocation!.longitude),
            end: LatLng(
                ride.pickUpLocation.latitude, ride.pickUpLocation.longitude),
          );

      return driversRoutePoints;
    }

    Future<List<LatLng>> fetchPointsToFinalDestination(
        {required RideModel ride}) async {
      final destinationPoints = await ref
          .watch(suggestionControllerProvider.notifier)
          .getDriverRoute(
            start: LatLng(
                ride.driverLocation!.latitude, ride.driverLocation!.longitude),
            end: LatLng(ride.destination.latitude, ride.destination.longitude),
          );

      return destinationPoints;
    }

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

      return points;
    }

    void generatePolylineFromPoints({required List<LatLng> points}) async {
      final polyline = Polyline(
          polylineId: PolylineId("1"),
          points: points,
          width: 5,
          color: Colors.yellow);
      polylinesStateT.value = {PolylineId("1"): polyline};
    }

    Future<void> initializeDriverRoute({required RideModel ride}) async {
      print("DRIVER FUNCTION");
      await fetchPointsForDriversRoute(ride: ride)
          .then((value) => generatePolylineFromPoints(points: value));
    }

    Future<void> initilazeMap() async {
      await fetchPolylinePoints()
          .then((value) => generatePolylineFromPoints(points: value));
    }

    Future<void> setRouteToDestination({required RideModel ride}) async {
      await fetchPointsToFinalDestination(ride: ride)
          .then((value) => generatePolylineFromPoints(points: value));
    }

    ref.listen(ridesStreamProvider, (previous, next) {
      // final previousRide = previous?.value
      //     ?.where((element) =>
      //         element.acceptedRide == true && element.driverId == user.id)
      //     .toList()[0];

      final currentRide = next.value
          ?.where((element) =>
              element.acceptedRide == true && element.driverId == user.id)
          .toList()[0];
      if (currentRide != null) {
        if (currentRide.acceptedRide & currentRide.driverPickConfirm == false ||
            currentRide.passengerConfrim == false) {
          initializeDriverRoute(ride: currentRide);
        } else if (currentRide.driverPickConfirm &
            currentRide.passengerConfrim) {
          setRouteToDestination(ride: currentRide);
        }
      }
    });

    ref.listen(userStreamProvider, (previous, next) {
      final previousUser = previous?.value?[0];
      final currentUser = next.value![0];

      if (previousUser?.findRoute != currentUser.findRoute &&
          currentUser.findRoute) {
        fetchPolylinePoints();
      } else if (previousUser?.settingPickUp != currentUser.settingPickUp &&
          currentUser.settingPickUp) {
        _pickUpAreaVisible.value = true;
      } else if (previousUser?.lookingForDriver !=
              currentUser.lookingForDriver &&
          currentUser.lookingForDriver) {
        _pickUpAreaVisible.value = false;

        initilazeMap();
      } else if (previousUser?.localization != currentUser.localization) {
        ref
            .read(locationControllerProvider.notifier)
            .updateLocation(userId: user.id);
      }
    });
    useEffect(() {
      // final user = ref.watch(userStreamProvider).value![0];

      return;
    });
    return Scaffold(
      // appBar: isWriting == false
      //     ? null
      //     :
      //     AppBar(
      //         shadowColor: Color.fromARGB(31, 0, 0, 0),
      //         backgroundColor: ThemeData.dark().colorScheme.onSecondary,
      //         leading: IconButton(
      //             onPressed: () {
      //               ref.read(isWritingProvider.notifier).state = false;

      //               ref.read(panelHeightProvider.notifier).state * 0.75;
      //             },
      //             icon: Icon(Icons.cancel_sharp)),
      //       ),
      body: Stack(
        children: [
          MapPicker(
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
                        user.localization!.longitude)),
                Marker(
                    visible: user.lookingForDriver,
                    markerId: MarkerId("destination"),
                    icon: BitmapDescriptor.defaultMarker,
                    position: LatLng(user.destination!.latitude,
                        user.destination!.longitude)),

                for (final marker in user.userType == UserType.client.toString()
                    ? driversMarkers
                    : []) ...[marker]
              },
              polylines: user.lookingForDriver == false &&
                      user.userType == UserType.client.toString()
                  ? Set()
                  : Set<Polyline>.of(polylinesStateT.value.values),
            ),
          ),
          BottomPanel(
              height: height,
              isWriting: isWriting,
              width: width,
              keyboardSize: keyboardSize),
          TopPanel(width: width, height: height),
        ],
      ),
    );
  }
}
