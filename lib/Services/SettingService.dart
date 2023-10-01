import 'package:dgi/db/SettingRepository.dart';
import 'package:dgi/model/settings.dart';

class SettingService{
  final _settingRepository = SettingRepository();
  Future<int> insert(Setting setting) async {
    return _settingRepository.insert(setting);
  }
  Future<List<Setting>> retrieve() async {
    return _settingRepository.retrieve();
  }
}