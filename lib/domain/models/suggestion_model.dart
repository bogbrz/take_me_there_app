import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggestion_model.freezed.dart';

@freezed
class SuggestionModel with _$SuggestionModel {
  factory SuggestionModel({
    required String streetName,
    
  }) = _SuggestionModel;
}
