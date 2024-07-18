import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:take_me_there_app/domain/models/place_model.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';
import 'package:take_me_there_app/providers/is_writing_provider.dart';

class BottomPanel extends HookConsumerWidget {
  const BottomPanel(
      {super.key,
      required this.height,
      required this.isWriting,
      required this.width,
      required this.keyboardSize});
  final double keyboardSize;
  final double height;
  final bool isWriting;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomPanelController = ref.watch(bottomPanelControllerProvider);
    final topPanelController = ref.watch(topPanelControllerProvider);
    final isTyping = ref.watch(isTypingProvider);
    final isWriting = ref.watch(isWritingProvider);
    final textController = ref.watch(destinationTextControllerProvider);
    final panelHeight = ref.watch(panelHeightProvider.notifier).state;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final _suggestions = useState<List<Result>>([]);
    final lenght = useState<double>(650);
    final currentHeight = useState<double>(0);

    final places = ref.watch(suggestionControllerProvider.notifier);
    void suggestionList(String address) async {
      final listOfResults =
          await places.getSuggestions(address: textController.text);
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

    void startWritingPanels() {
      // ref.read(isWritingProvider.notifier).state = true;
      topPanelController.open();
      bottomPanelController.open();
    }

    void endWritingPanels() {
      // ref.read(isWritingProvider.notifier).state = false;
      topPanelController.close();
      bottomPanelController.close();
    }

    ref.listen(isWritingProvider, (previous, next) {
      final previousState = previous;
      final currentState = next;
      if (previousState != currentState && currentState == true) {
        startWritingPanels();
        currentHeight.value = lenght.value;
      } else {
        endWritingPanels();
      }
    });

    ref.listen(isTypingProvider, (previous, next) {
      final previousState = previous;
      final currentState = next;
      if (currentState == false) {
        lenght.value = height;
      } else {
        lenght.value = height - 650; //WRITING LENGHT
      }
    });
    return SlidingUpPanel(
      controller: bottomPanelController,
      maxHeight: lenght.value,
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
          ? ListView.builder(
              itemCount: _suggestions.value.length,
              itemBuilder: (context, index) {
                final suggestion = _suggestions.value[index];
                return InkWell(
                  onTap: () {
                    textController.text = suggestion.address?.streetName ??
                        suggestion.address?.country ??
                        "null";
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
              })
          : Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(isWritingProvider.notifier).state = true;

                      ref.read(isTypingProvider.notifier).state = false;
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
