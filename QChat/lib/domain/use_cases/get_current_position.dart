import 'package:chat_app/data/models/positon_model.dart';
import 'package:chat_app/domain/repositories/location_repository.dart';

class GetCurrentPosition{
  final LocationRepository repository;

  GetCurrentPosition(this.repository);

  Future<PositionEntity> call() async{
    return await repository.getCurrentPosition();
  }
}