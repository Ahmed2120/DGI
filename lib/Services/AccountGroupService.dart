import 'package:dgi/db/AccountGroupRepository.dart';
import 'package:dgi/model/accountGroup.dart';

class AccountGroupService{
  AccountGroupRepository accountGroupRepository = AccountGroupRepository();
  Future<int> insert(AccountGroup accountGroup) async {
    return accountGroupRepository.insert(accountGroup);
  }
  Future<List<AccountGroup>> retrieve() async {
    return accountGroupRepository.retrieve();
  }
  Future<int> batch(List<AccountGroup> accountGroups) async {
    return accountGroupRepository.batch(accountGroups);
  }
  Future<void> delete(int id) async {
    return accountGroupRepository.delete(id);
  }
}