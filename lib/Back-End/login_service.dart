import 'package:login_app/Back-End/repo.dart';
import 'loginmodal.dart';

class LoginService {
  late Repo _repo;
  LoginService() {
    _repo = Repo();
  }

  saveUser(Login login) async {
    
    return await _repo.insertData('User', login.toJson());
  }

  readAllDetails() async {
    return await _repo.readData('User');
  }

  checkValidUser(name, password) async {
    return await _repo.readUser(name, password);
  }
}
