import 'package:take_me_there_app/domain/models/option_model.dart';

final optionsList = <OptionModel>[
  OptionModel(
      image: "assets/hatchback.png",
      name: "Standard",
      payRate: 1.1,
      currency: "PLN"),
  OptionModel(
      image: "assets/electric.png",
      name: "Eco-friendly",
      payRate: 1.2,
      currency: "PLN"),
  OptionModel(
      image: "assets/cabriolet.png",
      name: "High class",
      payRate: 1.5,
      currency: "PLN"),
  OptionModel(
      image: "assets/van.png", name: "Carriage", payRate: 1.3, currency: "PLN")
];
