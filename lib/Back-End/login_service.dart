import 'package:login_app/Back-End/repo.dart';
import 'loginmodal.dart';

class LoginService {
  late Repo _repo;
  LoginService() {
    _repo = Repo();
  }

  saveUser(Login login) async {
    //  print(todo);
    return await _repo.insertData('User', login.toJson());
  }

  readAllFriends() async {
    return await _repo.readData('User');
  }

  checkValidUser(name, password) async {
    return await _repo.readUser(name,password);
  }

  updateFriends(Login login) async {
    return await _repo.updateData('User', login.toJson());
  }
}
