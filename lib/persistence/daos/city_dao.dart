import 'package:hive/hive.dart';

import '../../data/vos/city_vo.dart';
import '../hive_constants.dart';

class CityDao{
  static final CityDao _singleton = CityDao._internal();

  factory CityDao(){
    return _singleton;
  }

  CityDao._internal();

  void saveAllCities(List<CityVO> citiesList) async {
    Map<int,CityVO> cityMap = Map.fromIterable(citiesList,key:(city) => city.id,value:(city) => city);
    await getCityBox().putAll(cityMap);
  }

  List<CityVO> getAllCities(){
    return getCityBox().values.toList();
  }

  CityVO? getCityById(cityId){
    return getCityBox().get(cityId);
  }

  Box<CityVO> getCityBox() {
    return Hive.box<CityVO>(BOX_NAME_CITY_VO);
  }
}