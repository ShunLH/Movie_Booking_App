import 'package:hive/hive.dart';

import '../../data/vos/snack_category_vo.dart';
import '../../data/vos/snack_vo.dart';
import '../hive_constants.dart';

class SnackCategoryDao{
  static final SnackCategoryDao _singleton = SnackCategoryDao._internal();

  factory SnackCategoryDao(){
    return _singleton;
  }

  SnackCategoryDao._internal();

  void saveAllSnackCategories(List<SnackCategoryVO> snackCategoriesList) async {
    Map<int,SnackCategoryVO> snackcategoriesMap = Map.fromIterable(snackCategoriesList,key:(category) => category.id,value:(category) => category);
    await getSnackCategoryBox().putAll(snackcategoriesMap);
  }

  List<SnackCategoryVO> getAllSnackCategories(){
    return getSnackCategoryBox().values.toList();
  }

  Box<SnackCategoryVO> getSnackCategoryBox() {
    return Hive.box<SnackCategoryVO>(BOX_NAME_SNACK_CATEGORY_VO);
  }
}