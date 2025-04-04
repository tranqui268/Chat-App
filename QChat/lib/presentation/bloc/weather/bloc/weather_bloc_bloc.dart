import 'package:bloc/bloc.dart';
import 'package:chat_app/api_key.dart';
import 'package:chat_app/domain/entities/position_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';


part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async{
      emit(WeatherLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        
        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude, 
          event.position.longitude
        );
        print(weather);
        emit(WeatherSuccess(weather));

      } catch (e) {
        emit(WeatherFailure()); 
      }
    });
  }
}
