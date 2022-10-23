import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema_day_timeslots_vo.dart';

import '../../persistence/hive_constants.dart';
part 'movie_date_timeslots_vo.g.dart';

@HiveType(typeId: HYPE_TYPE_ID_MOVIE_DATE_TIMESLOTS_VO,adapterName: "MovieDateTimeSlotsVOAdapter")
class MovieDateTimeSlotsVO {

  @HiveField(0)
  String? date;

  @HiveField(1)
  List<CinemaDayTimeslotsVO>? cinemaDayTimeSlotsList;

  MovieDateTimeSlotsVO(this.date, this.cinemaDayTimeSlotsList);

}