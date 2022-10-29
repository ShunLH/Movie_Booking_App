import 'package:hive/hive.dart';

import '../../data/vos/snack_vo.dart';
import '../hive_constants.dart';

class SnackDao{
  static final SnackDao _singleton = SnackDao._internal();

  factory SnackDao(){
    return _singleton;
  }

  SnackDao._internal();

  void saveAllSnacks(List<SnackVO> snacksList) async {
    Map<int,SnackVO> snacksMap = Map.fromIterable(snacksList,key:(snack) => snack.id,value:(snack) => snack);
    await getSnackBox().putAll(snacksMap);
  }

  List<SnackVO> getAllSnacks(){
    return getSnackBox().values.toList();
  }

  List<SnackVO> getSnacksByCategoryId(int categoryId){
    return getSnackBox().values.where((snack) => snack.categoryId == categoryId).toList();
  }

  Box<SnackVO> getSnackBox() {
    return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }
  ///Reactive

  Stream<void> getAllSnackEventStream() {
    return getSnackBox().watch();
  }

  Stream<List<SnackVO>> getAllSnacksStream(){
    return Stream.value(getAllSnacks());
  }
}