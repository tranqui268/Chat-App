import 'package:chat_app/data/models/positon_model.dart';

abstract class LocationRepository{
  Future<PositionEntity> getCurrentPosition();
}