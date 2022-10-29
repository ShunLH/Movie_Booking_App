import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data/vos/payment_type_vo.dart';

class PaymentTypeDao{
  static final PaymentTypeDao _singleton = PaymentTypeDao._internal();

  factory PaymentTypeDao(){
    return _singleton;
  }

  PaymentTypeDao._internal();

  void saveAllPaymentTypes(List<PaymentTypeVO> paymentTypeList) async {
    Map<int,PaymentTypeVO> paymentTypeMap = Map.fromIterable(paymentTypeList,key:(paymentType) => paymentType.id,value:(paymentType) => paymentType);
    await getPaymentTypeBox().putAll(paymentTypeMap);
  }


  List<PaymentTypeVO> getAllPaymentTypes(){
    return getPaymentTypeBox().values.toList();
  }

  Box<PaymentTypeVO> getPaymentTypeBox() {
    return Hive.box<PaymentTypeVO>(BOX_NAME_PAYMENT_TYPE_VO);
  }
///Reactive
  Stream<void> getAllPaymentTypeEventStream() {
    return getPaymentTypeBox().watch(); //notify to listeners
  }

  Stream<List<PaymentTypeVO>> getPaymentTypesStream() {
    return Stream.value(getAllPaymentTypes());
  }
}