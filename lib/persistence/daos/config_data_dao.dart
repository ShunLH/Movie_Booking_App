


import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data/vos/config_data_vo.dart';

class ConfigDataDao{
  static final ConfigDataDao _singleton = ConfigDataDao._internal();

  factory ConfigDataDao(){
    return _singleton;
  }

  ConfigDataDao._internal();

  void saveAllConfigs(List<ConfigDataVO> configList) async {
    Map<int,ConfigDataVO> configMap = Map.fromIterable(configList,key:(config) => config.id,value:(config) => config);
    await getConfigBox().putAll(configMap);
  }

  List<ConfigDataVO> getAllConfigs(){
    return getConfigBox().values.toList();
  }

  Box<ConfigDataVO> getConfigBox() {
    return Hive.box<ConfigDataVO>(BOX_NAME_CONFIG_DATA_VO);
  }
}