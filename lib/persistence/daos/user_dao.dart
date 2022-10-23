
import 'package:hive/hive.dart';

import '../../data/vos/city_vo.dart';
import '../../data/vos/user_vo.dart';
import '../hive_constants.dart';

class UserDao{
  static final UserDao _singleton = UserDao._internal();

  factory UserDao(){
    return _singleton;
  }

  UserDao._internal();

  void saveAllUsers(List<UserVO> userList) async {
    Map<int,UserVO> userMap = Map.fromIterable(userList,key:(user) => user.id,value:(user) => user);
    await getUserBox().putAll(userMap);
  }

  void saveUser(UserVO user) async {
    await getUserBox().put(user.id,user);
  }
  List<UserVO?> getAllUsers(){
    return getUserBox().values.toList();
  }

  String getToken(){
    return getUserBox().values.first.token ?? "";
  }

  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }
}