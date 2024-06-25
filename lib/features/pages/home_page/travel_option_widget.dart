import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/domain/models/option_model.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';
import 'package:take_me_there_app/features/pages/home_page/options_list.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TravelOptionWidget extends HookConsumerWidget {
  const TravelOptionWidget({
    required this.pickUpPlace,
    required this.destinationPlace,
    required this.destination,
    required this.pickUp,
    required this.distance,
    required this.userId,
    super.key,
  });
  final String pickUpPlace;
  final String userId;
  final String destinationPlace;
  final LatLng? pickUp;
  final LatLng? destination;
  final double distance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isChoosen = useState<bool>(false);
    final _chosenOption = useState<OptionModel?>(null);

    if (_isChoosen.value == false) {
      return Expanded(
        child: Column(
          children: [
            Text("Choose your service"),
            Expanded(
              child: ListView(children: [
                for (final option in optionsList) ...[
                  Material(
                    child: InkWell(
                      onTap: () {
                        _chosenOption.value = option;
                        _isChoosen.value = true;
                        ref
                            .read(suggestionControllerProvider.notifier)
                            .updateOptionChosen(
                                userId: userId, optionChosen: _isChoosen.value);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(181, 167, 165, 165)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                height: 100,
                                child: Image(image: AssetImage(option.image))),
                            Text(option.name),
                            Text(
                                "${(option.payRate * (distance / 1000)).toStringAsFixed(2)} ${option.currency}")
                          ],
                        ),
                      ),
                    ),
                  )
                ]
              ]),
            )
          ],
        ),
      );
    } else {
      return ChosenOptionWidget(
        option: _chosenOption.value,
        distance: distance,
        userId: userId,
        destinationPlace: destinationPlace,
        pickUpPlace: pickUpPlace,
      );
    }
  }
}

class ChosenOptionWidget extends HookConsumerWidget {
  const ChosenOptionWidget({
    required this.option,
    required this.distance,
    required this.pickUpPlace,
    required this.userId,
    required this.destinationPlace,
    super.key,
  });
  final OptionModel? option;
  final double distance;
  final String pickUpPlace;
  final String userId;
  final String destinationPlace;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _settingPickUp = useState<bool>(false);
    final _paymentIcon = useState<StatelessWidget>(
      CardOption(),
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("From: $pickUpPlace"),
            Text("To: $destinationPlace"),
          ],
        ),
        Text("Choosen service"),
        Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(181, 167, 165, 165)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  height: 100, child: Image(image: AssetImage(option!.image))),
              Text(option!.name),
              Text(
                  "${(option!.payRate * (distance / 1000)).toStringAsFixed(2)} ${option!.currency}"),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: PopupMenuButton(
              onSelected: (value) {
                _paymentIcon.value = value;
              },
              icon: _paymentIcon.value,
              itemBuilder: ((context) => [
                    PopupMenuItem(
                      value: CardOption(),
                      child: CardOption(),
                    ),
                    PopupMenuItem(
                      value: CashOption(),
                      child: CashOption(),
                    )
                  ])),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.blueAccent,
            ),
            onPressed: () {
              _settingPickUp.value = true;
              // ref
              //     .read(suggestionControllerProvider.notifier)
              //     .updateLookingForDriver(
              //         userId: userId,
              //         lookingForDriver: _settingPickUp.value);
              ref
                  .read(suggestionControllerProvider.notifier)
                  .updateSettingPickUp(
                      userId: userId, settingPickUp: _settingPickUp.value);
            },
            child: Text("Take me there"))
      ],
    );
  }
}

class CardOption extends StatelessWidget {
  const CardOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
          children: [
            Image(
              image: AssetImage("assets/credit-card.png"),
            ),
            Text("****2137")
          ],
        ));
  }
}

class CashOption extends StatelessWidget {
  const CashOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
          children: [
            Image(
              image: AssetImage("assets/money.png"),
            ),
            Text(" Cash")
          ],
        ));
  }
}
