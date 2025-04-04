import 'dart:ui';

import 'package:chat_app/constant.dart';
import 'package:chat_app/data/data_sources/location_data_source.dart';
import 'package:chat_app/data/repositories/location_repository_impl.dart';
import 'package:chat_app/domain/entities/position_entity.dart';
import 'package:chat_app/domain/use_cases/get_current_position.dart';
import 'package:chat_app/presentation/bloc/weather/bloc/weather_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final locationDataSource = LocationDataSourceImpl();
  late final locationRepository = LocationRepositoryImpl(locationDataSource);
  late final getCurrentPosition = GetCurrentPosition(locationRepository);

  Widget getWeatherIcon(int code){
    switch (code) {
      case >=200 && <300:
        return Image.asset(
          'assets/images/1.png'
        );
      case >=300 && <400:
        return Image.asset(
          'assets/images/2.png'
        );
      case >=500 && <600:
        return Image.asset(
          'assets/images/3.png'
        );
      case >=600 && <700:
        return Image.asset(
          'assets/images/4.png'
        );
      case >=700 && <800:
        return Image.asset(
          'assets/images/5.png'
        );
      case 800:
        return Image.asset(
          'assets/images/6.png'
        );
      case >800 && <=804:
        return Image.asset(
          'assets/images/7.png'
        );
      default:
      return Image.asset(
        'assets/images/7.png'

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: FutureBuilder(
          future: getCurrentPosition(),
          builder: (context, snap) {
            if (snap.hasData) {
              return BlocProvider<WeatherBlocBloc>(
                create: (context) => WeatherBlocBloc()
                  ..add(FetchWeather(snap.data as PositionModel)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      40, 1.2 * kToolbarHeight, 40, 20),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(3, -0.3),
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Constants.primaryColor),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(-3, -0.3),
                          child: Container(
                            height: 300,
                            width: 300,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, -1.2),
                          child: Container(
                            height: 300,
                            width: 600,
                            decoration:
                                const BoxDecoration(color: Color(0xFFFF7A00)),
                          ),
                        ),
                        BackdropFilter(
                          filter:
                              ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                          ),
                        ),
                        BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                          builder: (context, state) {
                            if (state is WeatherSuccess) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.weather.areaName}',
                                    style:const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  const Text(
                                    'Good morning',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Image.asset('assets/images/1.png'),
                                  getWeatherIcon(state.weather.weatherConditionCode!),
                                  Center(
                                    child: Text(
                                      '${state.weather.temperature!.celsius?.round()}℃',
                                      style:const TextStyle(
                                          color: Colors.white,
                                          fontSize: 55,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      state.weather.weatherMain!.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      DateFormat('EEEE dd -').add_jm().format(state.weather.date!),
                                      // 'Friday 16 - 14:02pm',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/11.png',
                                            scale: 8,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Sunrise',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                DateFormat().add_jm().format(state.weather.sunrise!),
                                                // '5:34 am',
                                                style:const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/12.png',
                                            scale: 8,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Sunset',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                DateFormat().add_jm().format(state.weather.sunset!),
                                                // '6:00 pm',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        Image.asset(
                                          'assets/images/13.png',
                                          scale: 8,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Temp Max',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              '${state.weather.tempMax!.celsius!.round()}℃',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        )
                                      ]),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/14.png',
                                            scale: 8,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Temp Min',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                               '${state.weather.tempMin!.celsius!.round()}℃',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                            }else{
                              return Container();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}
