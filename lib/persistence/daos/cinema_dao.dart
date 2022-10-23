import 'package:hive/hive.dart';

import '../../data/vos/cinema_vo.dart';
import '../hive_constants.dart';

class CinemaDao{
  static final CinemaDao _singleton = CinemaDao._internal();

  factory CinemaDao(){
    return _singleton;
  }

  CinemaDao._internal();

  void saveAllCinemas(List<CinemaVO> cinemasList) async {
    Map<int,CinemaVO> cinemaMap = Map.fromIterable(cinemasList,key:(cinema) => cinema.id,value:(cinema) => cinema);
    await getCinemaBox().putAll(cinemaMap);
  }

  List<CinemaVO> getAllCinemas(){
    return getCinemaBox().values.toList();
  }

  Box<CinemaVO> getCinemaBox() {
    return Hive.box<CinemaVO>(BOX_NAME_CINEMA_VO);
  }
}