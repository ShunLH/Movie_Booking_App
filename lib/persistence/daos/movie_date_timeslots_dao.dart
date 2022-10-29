

import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/movie_date_timeslots_vo.dart';

import '../hive_constants.dart';

class MovieDateTimeSlotDao{
  static final MovieDateTimeSlotDao _singleton = MovieDateTimeSlotDao._internal();

  factory MovieDateTimeSlotDao(){
    return _singleton;
  }

  MovieDateTimeSlotDao._internal();

  void saveAllMovieDateTimeSlotDao(List<MovieDateTimeSlotsVO> timeslotsList) async {
    Map<String,MovieDateTimeSlotsVO> timeslotsMap = Map.fromIterable(timeslotsList,key:(timeslot) => timeslot.date,value:(timeslot) => timeslot);
    await getMobvieDateTimeSlotsBox().putAll(timeslotsMap);
  }

  void saveSingleMovieDateTimeSlotDaoByDate(MovieDateTimeSlotsVO movieDateTimeSlot) async {
    await getMobvieDateTimeSlotsBox().put(movieDateTimeSlot.date,movieDateTimeSlot);
  }

  List<MovieDateTimeSlotsVO> getAllMobvieDateTimeSlots(){
    return getMobvieDateTimeSlotsBox().values.toList();
  }

  MovieDateTimeSlotsVO? getMovieDateTimeSlotsByDate(String date){
    return getMobvieDateTimeSlotsBox().get(date);
  }

  Box<MovieDateTimeSlotsVO> getMobvieDateTimeSlotsBox() {
    return Hive.box<MovieDateTimeSlotsVO>(BOX_NAME_MOVIE_DATE_TIMESLOTS_VO);
  }

  ///Reactive

  Stream<void> getAllMovieDateTimeSlotsByDateEventStream() {
    return getMobvieDateTimeSlotsBox().watch();
  }

  Stream<List<MovieDateTimeSlotsVO>> getMovieDateTimeSlotsStream() {
    return Stream.value(getAllMobvieDateTimeSlots());
  }

}