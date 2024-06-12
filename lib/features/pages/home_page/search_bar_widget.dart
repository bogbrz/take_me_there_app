import 'package:flutter/material.dart';
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
        useState<double?>(MediaQuery.of(context).size.height * 0.25);
    final _focusNode = useFocusNode();
    final _adress = useState<String?>(null);
    final _suggestions = useState<List<String>?>([]);
    final _isSearchingPickUp = useState<bool>(false);
    final _isSearchingDestination = useState<bool>(false);

    bool areFieldsEmpty() {
      return pickUpLocationController.text.toString().isEmpty ||
          destinationController.text.toString().isEmpty;
    }

    final _token = useState<String>("37465");
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
            horizontal: MediaQuery.of(context).size.width * 0.08,
            vertical: MediaQuery.of(context).size.width * 0.025),
        child: Column(
          children: [
            widgetContetController.value == 1
                ? Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          _searchBarHeigh.value =
                              MediaQuery.of(context).size.height * 0.25;
                          widgetContetController.value = 0;
                        },
                        icon: Icon(Icons.arrow_back)),
                  )
                : SizedBox.shrink(),
            Column(
              children: [
                if (widgetContetController.value == 0) ...[
                  TextField(
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
                              MediaQuery.of(context).size.height * 0.25
                          : _focusNode.requestFocus();
                      _isSearchingPickUp.value = false;
                      _isSearchingDestination.value = true;
                    },
                    controller: pickUpLocationController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: "Where would you like to be picked up?"),
                  ),
                  _isSearchingPickUp.value &&
                          pickUpLocationController.text.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ListView.builder(
                              itemCount: _suggestions.value!.length,
                              itemBuilder: (context, index) {
                                final suggestion = _suggestions.value![index];
                                return Text(suggestion);
                              }),
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                      focusNode: _focusNode,
                      controller: destinationController,
                      onTap: () {
                        _searchBarHeigh.value =
                            MediaQuery.of(context).size.height * 0.8;
                        _isSearchingDestination.value = true;
                      },
                      onChanged: (value) {
                        suggestionList(value);
                        _suggestions.value!.clear();
                      },
                      onSubmitted: (value) {
                        _searchBarHeigh.value =
                            MediaQuery.of(context).size.height * 0.25;
                        _isSearchingDestination.value = false;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          border: OutlineInputBorder(),
                          hintText: "Where would you like to be taken?")),
                  _isSearchingDestination.value &&
                          destinationController.text.isNotEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ListView.builder(
                              itemCount: _suggestions.value!.length,
                              itemBuilder: (context, index) {
                                final suggestion = _suggestions.value![index];
                                return Text(suggestion);
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
                                  MediaQuery.of(context).size.height * 0.4;
                              widgetContetController.value = 1;
                              pickUpLocationController.clear();
                              destinationController.clear();
                            },
                      child: Text("Take me there"),
                    )),
                  ),
                ] else ...[
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
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
