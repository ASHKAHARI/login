import 'package:login_app/Back-End/repo.dart';
import 'friendsmodal.dart';

class FriendsService {
  late Repo _repo;
  FriendsService() {
    _repo = Repo();
  }

  saveFriends(Login login) async {
    //  print(todo);
    return await _repo.insertData('Friends', login.toJson());
  }

  readAllFriends() async {
    return await _repo.readData('Friends');
  }

  updateFriends(Login login) async {
    return await _repo.updateData('Friends', login.toJson());
  }
}
