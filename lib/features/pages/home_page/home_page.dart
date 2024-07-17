import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks_bloc/flutter_hooks_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:map_picker/map_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:take_me_there_app/app/core/device_size.dart';
import 'package:take_me_there_app/app/core/enums.dart';
import 'package:take_me_there_app/domain/models/ride_model.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';
import 'package:take_me_there_app/features/pages/home_page/search_bar_widget.dart';
import 'package:take_me_there_app/features/pages/home_page/sliding_panel.dart';
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

    // final clients = ref.watch(clientUsersStreamProvider).value ?? [];

    void startWritingPanels() {
      // ref.read(isWritingProvider.notifier).state = true;
      bottomPanelController.open();
      topPanelController.open();
    }

    void endWritingPanels() {
      // ref.read(isWritingProvider.notifier).state = false;
      bottomPanelController.close();
      topPanelController.close();
    }

    ref.listen(isWritingProvider, (previous, next) {
      final previousState = previous;
      final currentState = next;
      if (currentState == true) {
        startWritingPanels();
      } else {
        endWritingPanels();
      }
    });

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
          TopPanel(width: width, height: height),
          BottomPanel(height: height, isWriting: isWriting, width: width),
        ],
      ),
    );
  }
}

class TopPanel extends HookConsumerWidget {
  const TopPanel({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;

  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPanelController = ref.watch(topPanelControllerProvider);
    final textController = ref.watch(destinationTextControllerProvider);

    return SlidingUpPanel(
      isDraggable: false,
      footer: Row(
        children: [
          SizedBox(
            width: width * 0.9,
          ),
          IconButton(
              onPressed: () {
                ref.read(isWritingProvider.notifier).state = false;
              },
              icon: Icon(Icons.cancel))
        ],
      ),
      minHeight: 0,
      defaultPanelState: PanelState.CLOSED,
      controller: topPanelController,
      maxHeight: height * 0.25,
      slideDirection: SlideDirection.DOWN,
      color: ThemeData.dark().colorScheme.onSecondary,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      panel: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.065,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: Colors.white)),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        ref.read(isTypingProvider.notifier).state = false;
                      },
                      onTap: () {
                        ref.read(isTypingProvider.notifier).state = true;
                      },
                      controller: textController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(4),
                          isDense: true,
                          hintText: "Where to pick you up?"),
                    ),
                  ),
                  IconButton(
                      iconSize: 20,
                      onPressed: () {},
                      icon: Icon(Icons.my_location))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomPanel extends HookConsumerWidget {
  const BottomPanel({
    super.key,
    required this.height,
    required this.isWriting,
    required this.width,
  });

  final double height;
  final bool isWriting;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomPanelController = ref.watch(bottomPanelControllerProvider);
    final isTyping = ref.watch(isTypingProvider);

    return SlidingUpPanel(
      maxHeight: height * 0.75,
      controller: bottomPanelController,
      slideDirection: SlideDirection.UP,
      header: isWriting == false
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * 0.4,
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: width * 0.02, bottom: width * 0.02),
                  height: height * 0.01,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(115, 158, 158, 158),
                      borderRadius: BorderRadius.circular(width * 0.01)),
                ),
                SizedBox(
                  width: width * 0.4,
                ),
              ],
            )
          : null,
      color: ThemeData.dark().colorScheme.onSecondary,
      panel: isWriting
          ? SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(isWritingProvider.notifier).state = true;
                    },
                    child: Container(
                      height: height * 0.065,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.white)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.search),
                          Text("Where do you want to go"),
                          IconButton.filled(
                              iconSize: 20,
                              onPressed: () {},
                              icon: Icon(
                                Icons.my_location,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
