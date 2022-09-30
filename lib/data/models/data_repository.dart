import 'package:movie_booking_app/data/vos/cinema_timeslot_status_vo.dart';
import 'package:movie_booking_app/data/vos/cinema_vo.dart';
import 'package:movie_booking_app/data/vos/config_data_vo.dart';

import '../vos/city_vo.dart';

class DataRepository {
  static final DataRepository _singleton = DataRepository._internal();

  String? token;
  CityVO? location;
  List<ConfigDataVO>? cinemaConfigList;
  List<CinemaTimeSlotStatusVO>? cinemaTimeSlotStatusList;
  List<CinemaVO>? cinemaList;
  factory DataRepository() {
    return _singleton;
  }

  DataRepository._internal() {}

  String getAuthorizationToken() {
    return "Bearer ${token}";
  }
}

DataRepository dataRepository = DataRepository();
