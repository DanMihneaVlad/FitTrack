import 'package:fit_track/models/user_model.dart';
import 'package:fit_track/services/user_service.dart';
import 'package:flutter/cupertino.dart';

class UserDetailsProvider extends ChangeNotifier {
  late UserService _userService;
  late UserModel user;
  late Future getUserDetails;
  final String uid;

  UserDetailsProvider({required this.uid}) {
    _userService = UserService(uid: uid);
    getUserDetails = _getUserDetailsFuture();
  }

  Future _getUserDetailsFuture() async {
    user = await _userService.getUserDetails();
  }
}