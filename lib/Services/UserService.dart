import 'package:dgi/db/UserRepository.dart';
import 'package:dgi/model/User.dart';

class UserService{
  UserRepository userRepository = UserRepository();
  Future<int> insert(User user) async {
    return userRepository.insert(user);
  }
  Future<List<User>> retrieve() async {
    return userRepository.retrieve();
  }
  Future<int> batch(List<User> users) async {
    return userRepository.batch(users);
  }
}