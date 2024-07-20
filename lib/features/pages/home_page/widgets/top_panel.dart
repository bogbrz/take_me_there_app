import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:take_me_there_app/app/core/device_size.dart';
import 'package:take_me_there_app/domain/models/place_model.dart';
import 'package:take_me_there_app/domain/models/way_point_model.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';
import 'package:take_me_there_app/features/pages/home_page/widgets/panels_controler.dart';
import 'package:take_me_there_app/providers/is_writing_provider.dart';

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

    final panelHeight = ref.watch(panelHeightProvider);
    final textFieldsAmount = useState<int>(2);
    final heightMultiplayer = useState<double>(0.25);
    final wayPoints = ref.watch(wayPointsProvider).value ?? [];
    print("WAYPOINTS : $wayPoints");
    return SlidingUpPanel(
      isDraggable: false,
      minHeight: 0,
      defaultPanelState: PanelState.CLOSED,
      controller: topPanelController,
      maxHeight: height * heightMultiplayer.value,
      slideDirection: SlideDirection.DOWN,
      color: ThemeData.dark().colorScheme.onSecondary,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      panel: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(59, 0, 0, 0),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        ref.read(isWritingProvider.notifier).state = false;

                        ref.read(panelHeightProvider.notifier).state * 0.75;
                      },
                      icon: Icon(Icons.cancel_sharp)),
                  IconButton(
                      onPressed: wayPoints.length >= 4
                          ? null
                          : () {
                              heightMultiplayer.value += 0.07;

                              ref
                                  .read(wayPointControllerProvider.notifier)
                                  .addWayPoint(index: wayPoints.length);
                            },
                      icon: Icon(Icons.add_box)),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: wayPoints.length,
                  itemBuilder: (context, index) {
                    print("WAYPOINTS : $wayPoints");
                    final wayPoint = wayPoints[index];
                    return wayPoint.index == 2 || wayPoint.index == 3
                        ? Dismissible(
                            key: ValueKey(wayPoint.index),
                            onDismissed: (direction) {
                              heightMultiplayer.value -= 0.07;
                              ref
                                  .read(wayPointControllerProvider.notifier)
                                  .removeWayPoint(wayPointId: wayPoint.id);
                            },
                            child: TextFieldWidget(
                              wayPointModel: wayPoint,
                            ))
                        : TextFieldWidget(
                            wayPointModel: wayPoint,
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends HookConsumerWidget {
  const TextFieldWidget({super.key, required this.wayPointModel});
  final WayPointModel wayPointModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _suggestions = useState<List<Result>>([]);
    final places = ref.watch(suggestionControllerProvider.notifier);
    final focusNode = FocusNode();
    final focusNumber = ref.watch(focusNumberProvider);
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

    ref.listen(focusNumberProvider, (previous, next) {
      if (next == wayPointModel.index) {
        focusNode.requestFocus();
      } else {
        focusNode.removeListener(() {});
      }
    });

    double width = DeviceSize(context).width;
    final textController = useTextEditingController();
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.white)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                autofocus: wayPointModel.index == 1 ? true : false,
                focusNode: wayPointModel.index != 1 ? focusNode : null,
                onChanged: (value) {
                  ref.read(textValueProvider.notifier).state = value;
                  ref.read(searchingProvider.notifier).state = true;
                },
                onSubmitted: (value) {
                  // ref.read(isTypingProvider.notifier).state = false;

                  // ref.read(isWritingProvider.notifier).state = false;
                  if (ref.read(focusNumberProvider.notifier).state == 4) {
                    null;
                  } 
                    ref.read(focusNumberProvider.notifier).state++;
                
                },
                onTap: () {
                  // ref.read(isTypingProvider.notifier).state = true;
                  ref.read(isTypingProvider.notifier).state = true;
                  ref.read(isWritingProvider.notifier).state = true;
                },
                controller: textController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(4),
                    isDense: true,
                    hintText: wayPointModel.index == 1
                        ? "Start"
                        : wayPointModel.index == 4
                            ? " End"
                            : "Add waypoint"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    icon: Icon(Icons.map_outlined)),
                wayPointModel.index != 4 || wayPointModel.index != 1
                    ? SizedBox.shrink()
                    : IconButton(
                        iconSize: 20,
                        onPressed: () {},
                        icon: Icon(Icons.my_location)),
                // IconButton(
                //     iconSize: 20,
                //     onPressed: () {},
                //     icon: Icon(Icons.drag_handle)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
