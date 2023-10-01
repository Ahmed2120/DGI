import 'package:dgi/db/TransactionRepository.dart';
import 'package:dgi/model/transaction.dart';

class TransactionService{
  TransactionRepository transactionRepository = TransactionRepository();
  Future<int> insert(TransactionLookUp transaction) async {
    return transactionRepository.insert(transaction);
  }
  Future<List<TransactionLookUp>> retrieve() async {
    return transactionRepository.retrieve();
  }
  Future<int> insertCategories(List<TransactionLookUp> transactions) async {
    return transactionRepository.batch(transactions);
  }
  Future<void> delete(int id) async {
    return transactionRepository.delete(id);
  }
}