import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/domain/models/place_model.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';

class SearchBarWidget extends HookConsumerWidget {
  SearchBarWidget(
    this.userId, {
    super.key,
  });
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(suggestionControllerProvider.notifier);
    final pickUpLocationController = useTextEditingController();
    final destinationController = useTextEditingController();
    final widgetContetController = useState(0);
    final _areFieldsEmpty = useState<bool>(true);
    final _searchBarHeigh =
        useState<double?>(MediaQuery.of(context).size.height * 0.27);
    final _focusNode = useFocusNode();

    final _suggestions = useState<List<Result>>([]);
    final _isSearchingPickUp = useState<bool>(false);
    final _isSearchingDestination = useState<bool>(false);
    final _pickUpLatLng = useState<LatLng?>(null);
    final _destinationLatLng = useState<LatLng?>(null);
    final suggestionLenght = useState<double>(0);

    bool areFieldsEmpty() {
      return pickUpLocationController.text.toString().isEmpty ||
          destinationController.text.toString().isEmpty;
    }

    void suggestionList(String address) async {
      final listOfResults = await places.getSuggestions(address: address);
      if (listOfResults == null) {
        _suggestions.value = [];
      } else {
        _suggestions.value = listOfResults
            .where((result) =>
                result.address?.streetName != null ||
                result.address?.country != null)
            .toList();
      }
    }

    useEffect(() {
      pickUpLocationController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      destinationController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      return;
    }, []);

    return AnimatedSize(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOutCirc,
      child: Container(
        height: _searchBarHeigh.value,
        decoration: BoxDecoration(
            color: Color.fromARGB(173, 0, 0, 0),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.width * 0.025),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widgetContetController.value == 1
                ? Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          _searchBarHeigh.value =
                              MediaQuery.of(context).size.height * 0.27;
                          widgetContetController.value = 0;
                        },
                        icon: Icon(Icons.arrow_back)),
                  )
                : SizedBox.shrink(),
            if (widgetContetController.value == 0) ...[
              Column(
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
                            onTap: () {
                              _searchBarHeigh.value =
                                  MediaQuery.of(context).size.height * 0.8;
                              pickUpLocationController.text = "";
                              _isSearchingPickUp.value = true;
                            },
                            onChanged: (value) {
                              _suggestions.value.clear();
                              suggestionList(value);
                            },
                            onSubmitted: (value) {
                              value.isEmpty
                                  ? _searchBarHeigh.value =
                                      MediaQuery.of(context).size.height * 0.27
                                  : _focusNode.requestFocus();
                              _isSearchingPickUp.value = false;
                              _isSearchingDestination.value = true;
                            },
                            controller: pickUpLocationController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(4),
                                isDense: true,
                                hintText: "Where to pick you up?"),
                          ),
                        ),
                        IconButton(
                            iconSize: 20,
                            onPressed: () {
                              places.updateLocation(userId: userId);
                              pickUpLocationController.text = "";
                              pickUpLocationController.text =
                                  "Current Position";

                              _isSearchingPickUp.value = false;
                              _focusNode.requestFocus();
                            },
                            icon: Icon(Icons.my_location))
                      ],
                    ),
                  ),
                  _isSearchingPickUp.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                              itemCount: _suggestions.value.length,
                              itemBuilder: (context, index) {
                                final suggestion = _suggestions.value[index];
                                return InkWell(
                                  onTap: () {
                                    pickUpLocationController.text =
                                        suggestion.address?.streetName ??
                                            suggestion.address?.country ??
                                            "null";
                                    _isSearchingPickUp.value = false;
                                    if (suggestion.position != null) {
                                      _pickUpLatLng.value = LatLng(
                                          suggestion.position!.lat!,
                                          suggestion.position!.lon!);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    color: Color.fromARGB(255, 120, 29, 29),
                                    child: Text(
                                      "Name: ${suggestion.address?.streetName ?? ''} Munipacity: ${suggestion.address?.municipality ?? ''} POSITION: Lat: ${suggestion.position?.lat ?? ''} Lon: ${suggestion.position?.lon ?? ''}" ??
                                          suggestion.address?.country ??
                                          "null",
                                    ),
                                  ),
                                );
                              }),
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.065,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.white)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                              focusNode: _focusNode,
                              controller: destinationController,
                              onTap: () {
                                _searchBarHeigh.value =
                                    MediaQuery.of(context).size.height * 0.8;
                                _isSearchingDestination.value = true;
                                _isSearchingPickUp.value = false;
                              },
                              onChanged: (value) {
                                _suggestions.value.clear();
                                suggestionList(value);
                              },
                              onSubmitted: (value) {
                                _searchBarHeigh.value =
                                    MediaQuery.of(context).size.height * 0.27;
                                _isSearchingDestination.value = false;
                              },
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(4),
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Where to take you?")),
                        ),
                      ],
                    ),
                  ),
                  _isSearchingDestination.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                              itemCount: _suggestions.value.length,
                              itemBuilder: (context, index) {
                                final suggestion = _suggestions.value[index];
                                return InkWell(
                                  onTap: () {
                                    destinationController.text =
                                        suggestion.address?.streetName ??
                                            suggestion.address?.country ??
                                            "null";
                                    _isSearchingDestination.value = false;
                                    if (suggestion.position != null) {
                                      _destinationLatLng.value = LatLng(
                                          suggestion.position!.lat!,
                                          suggestion.position!.lon!);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    color: Color.fromARGB(255, 120, 29, 29),
                                    child: Text(
                                      suggestion.address?.streetName ??
                                          suggestion.address?.country ??
                                          "null",
                                    ),
                                  ),
                                );
                              }),
                        )
                      : SizedBox.shrink(),
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
                              _searchBarHeigh.value =
                                  MediaQuery.of(context).size.height * 0.5;
                              places.updateDestination(
                                  userId: userId,
                                  localization: _pickUpLatLng.value == null
                                      ? null
                                      : GeoPoint(_pickUpLatLng.value!.latitude,
                                          _pickUpLatLng.value!.longitude),
                                  destination: GeoPoint(
                                    _destinationLatLng.value!.latitude,
                                    _destinationLatLng.value!.longitude,
                                  ));
                              widgetContetController.value = 1;
                            },
                      child: Text("Take me there"),
                    )),
                  ),
                ],
              ),
            ] else ...[
              RouteSpecificationWidget(
                pickUpPlace: pickUpLocationController.value.text,
                destinationPlace: destinationController.value.text,
                destination: _destinationLatLng.value,
                pickUp: _pickUpLatLng.value,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class RouteSpecificationWidget extends HookConsumerWidget {
  const RouteSpecificationWidget({
    required this.pickUpPlace,
    required this.destinationPlace,
    required this.destination,
    required this.pickUp,
    super.key,
  });
  final String pickUpPlace;
  final String destinationPlace;
  final LatLng? pickUp;
  final LatLng? destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SizedBox(
        child: ListView(
          children: [
            Text("$pickUpPlace $pickUp,,,,, $destinationPlace $destination"),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.1,
            //   child: Image(
            //     image: AssetImage("assets/hatchback.png"),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
