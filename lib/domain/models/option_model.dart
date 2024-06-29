import 'package:freezed_annotation/freezed_annotation.dart';

part 'option_model.freezed.dart';

@freezed
class OptionModel with _$OptionModel {
  factory OptionModel({
    required String image,
    required String name, 
    required double  payRate,
    required String currency,

    
  }) = _OptionModel;
}
