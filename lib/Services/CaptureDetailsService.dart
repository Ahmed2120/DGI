import 'package:dgi/Utility/configration.dart';
import 'package:dgi/db/CaptureDetailsRepository.dart';
import 'package:dgi/model/CaptureDetails.dart';


class CaptureDetailsService{
  CaptureDetailsRepository captureDetailsRepository = CaptureDetailsRepository();
  Future<int> insert(CaptureDetails captureDetails) async {
    return captureDetailsRepository.insert(captureDetails);
  }
  Future<List<CaptureDetails>> retrieve() async {
    return captureDetailsRepository.retrieve();
  }
  Future<List<CaptureDetails>> retrieveTopElement() async {
    return captureDetailsRepository.retrieveTopElement(MyConfig.PAGE_SIZE);
  }
  update(List<CaptureDetails> items)async{
    return captureDetailsRepository.update(items);
  }
  Future<int> batch(List<CaptureDetails> captureDetails) async {
    return captureDetailsRepository.batch(captureDetails);
  }
  Future<void> delete(int id) async {
    return captureDetailsRepository.delete(id);
  }
}