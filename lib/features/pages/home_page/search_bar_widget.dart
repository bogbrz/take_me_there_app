import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';

class SearchBarWidget extends HookConsumerWidget {
  SearchBarWidget({
    super.key,
  });

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

    final _suggestions = useState<List<String>?>([]);
    final _isSearchingPickUp = useState<bool>(false);
    final _isSearchingDestination = useState<bool>(false);

    bool areFieldsEmpty() {
      return pickUpLocationController.text.toString().isEmpty ||
          destinationController.text.toString().isEmpty;
    }

    // void makeSuggestion(String adress) async {
    //   String googlePlacesApiKey = key;
    //   String groundURL =
    //       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    //   String request =
    //       '$groundURL?input=$adress&key=$googlePlacesApiKey&sessiontoken=$_token';

    //   _response.value = await Dio().get(request);

    //   print("RESULT DATA : ${_response.value}");
    // }
    void suggestionList(String adress) async {
      final placesList = await places.getSuggestions(address: adress);
      if (placesList == null) {
        _suggestions.value = null;
      } else {
        _suggestions.value!.addAll(placesList);
      }

      print("PAGE $placesList");
      print("LIST ${_suggestions.value}");
    }

    useEffect(() {
      pickUpLocationController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      destinationController.addListener(() {
        _areFieldsEmpty.value = areFieldsEmpty();
      });
      // focusNode = FocusNode();
      return;
    });

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
                              _isSearchingPickUp.value = true;
                            },
                            onChanged: (value) {
                              suggestionList(value);
                              _suggestions.value!.clear();
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
                            onPressed: () {},
                            icon: Icon(Icons.my_location))
                      ],
                    ),
                  ),
                  _isSearchingPickUp.value &&
                          pickUpLocationController.text.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                              itemCount: _suggestions.value!.length,
                              itemBuilder: (context, index) {
                                final suggestion = _suggestions.value![index];
                                return InkWell(
                                  onTap: () {
                                    pickUpLocationController.text = "";
                                    pickUpLocationController.text = suggestion;
                                    _isSearchingPickUp.value = false;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    color: Color.fromARGB(255, 120, 29, 29),
                                    child: Text(suggestion),
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
                                suggestionList(value);
                                _suggestions.value!.clear();
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
                  _isSearchingDestination.value &&
                          destinationController.text.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                              itemCount: _suggestions.value!.length,
                              itemBuilder: (context, index) {
                                final suggestion = _suggestions.value![index];
                                return InkWell(
                                  onTap: () {
                                    destinationController.text = "";
                                    destinationController.text = suggestion;
                                    _isSearchingDestination.value = false;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    color: Color.fromARGB(255, 120, 29, 29),
                                    child: Text(suggestion),
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
                              widgetContetController.value = 1;
                              // pickUpLocationController.clear();
                              // destinationController.clear();
                            },
                      child: Text("Take me there"),
                    )),
                  ),
                ],
              ),
            ] else ...[
              RouteSpecificationWidget(pickUpLocationController.value.text,
                  destinationController.value.text),
            ],
          ],
        ),
      ),
    );
  }
}

class RouteSpecificationWidget extends HookConsumerWidget {
  const RouteSpecificationWidget(
    this.pickUpPlace,
    this.destinationPlace, {
    super.key,
  });
  final String pickUpPlace;
  final String destinationPlace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SizedBox(
        child: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: Image(
                image: AssetImage("assets/hatchback.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
