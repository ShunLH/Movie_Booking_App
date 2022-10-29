
import 'package:hive/hive.dart';

import '../../data/vos/credit_vo.dart';
import '../hive_constants.dart';

class CreditDao{
  static final CreditDao _singleton = CreditDao._internal();

  factory CreditDao(){
    return _singleton;
  }

  CreditDao._internal();

  void saveAllCredits(List<CreditVO> creditsList) async {
    Map<int,CreditVO> creditsMap = Map.fromIterable(creditsList,key:(credit) => credit.id,value:(credit) => credit);
    await getCreditBox().putAll(creditsMap);
  }

  List<CreditVO> getAllCredits(){
    return getCreditBox().values.toList();
  }

  Box<CreditVO> getCreditBox() {
    return Hive.box<CreditVO>(BOX_NAME_CREDIT_VO);
  }

  ///Reactive

  Stream<void> getAllCreditsEventStream() {
    return getCreditBox().watch();
  }

  Stream<List<CreditVO>> getAllCreditsStream() {
    return Stream.value(getAllCredits());
  }
}