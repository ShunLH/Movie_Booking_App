import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data/vos/cinema_timeslot_status_vo.dart';

class CinemaTimeSlotStatusDao{
  static final CinemaTimeSlotStatusDao _singleton = CinemaTimeSlotStatusDao._internal();

  factory CinemaTimeSlotStatusDao() {
    return _singleton;
  }

  CinemaTimeSlotStatusDao._internal();

  void saveAllTimeSlotStatus(List<CinemaTimeSlotStatusVO> statusList) async {
    Map<int, CinemaTimeSlotStatusVO> cinemaMap = Map.fromIterable(statusList,
        key: (status) => status.id, value: (status) => status);
    await getCinemaTimeSlotStatusBox().putAll(cinemaMap);
  }

  List<CinemaTimeSlotStatusVO> getAllTimeSlotsStatus() {
    return getCinemaTimeSlotStatusBox().values.toList();
  }

  Box<CinemaTimeSlotStatusVO> getCinemaTimeSlotStatusBox() {
    return Hive.box<CinemaTimeSlotStatusVO>(BOX_NAME_CINEMA_TIMESLOT_STATUS_VO);
  }

  ///Reactive

  Stream<void> getAllTimeSlotsStatusEventStream() {
    return getCinemaTimeSlotStatusBox().watch();
  }

  Stream<List<CinemaTimeSlotStatusVO>> getAllTimeSlotStatusStream() {
    return Stream.value(getAllTimeSlotsStatus());
  }
}