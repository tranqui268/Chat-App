// lib/data/models/position_model.dart
import 'package:chat_app/data/models/positon_model.dart';

class PositionModel extends PositionEntity {
  PositionModel({required double latitude, required double longitude})
      : super(latitude: latitude, longitude: longitude);

  factory PositionModel.fromPosition(dynamic position) {
    return PositionModel(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}