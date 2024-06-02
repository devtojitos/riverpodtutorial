import 'package:riverpodtutorial/models/users_model.dart';

class UserPageData {
  UsersModel? data;

  UserPageData({
    required this.data,
  });

  UserPageData.initial() : data = null;

  UserPageData copyWith({UsersModel? data}) {
    return UserPageData(data: data ?? this.data);
  }
}
