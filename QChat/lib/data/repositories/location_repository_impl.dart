import 'package:chat_app/data/data_sources/location_data_source.dart';
import 'package:chat_app/data/models/positon_model.dart';
import 'package:chat_app/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository{
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<PositionEntity> getCurrentPosition() async{
    try {
      final positionModel = await dataSource.getCurrentPosition();
      return positionModel;
    } catch (e) {
      throw Exception('Failed to get current position: $e');
    }
  }
  
}