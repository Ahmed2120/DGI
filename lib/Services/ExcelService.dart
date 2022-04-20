import 'dart:io';
import 'package:dgi/Services/CaptureDetailsService.dart';
import 'package:dgi/Services/TransactionService.dart';
import 'package:dgi/model/CaptureDetails.dart';
import 'package:dgi/model/transaction.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelService{

  exportExcel()async{
    final captureService = CaptureDetailsService();
    final transactionService = TransactionService();
    List<TransactionLookUp> transactions = await transactionService.retrieve();

    final woe = Workbook();
    final Worksheet sheet = woe.worksheets[0];
    List<CaptureDetails> captureDetails = await captureService.retrieve();
    final List<String> firstRow = ['Id', 'Quantity', 'Image', 'Description',
      'DepartmentId', 'FloorId', 'SectionId', 'SerialNumber',
      'AssetLocationId' ,'ItemId' , 'TransactionId', 'Color',
      'Height' ,'Length' ,'Width'];
    sheet.importList(firstRow, 1, 1, false);
    for(int i = 0; i< captureDetails.length; i++){
      final List<Object?> list = [
        captureDetails[i].id!,
        captureDetails[i].quantity,
        captureDetails[i].image,
        captureDetails[i].description,
        captureDetails[i].departmentId,
        captureDetails[i].floorId,
        captureDetails[i].sectionId,
        captureDetails[i].serialNumber,
        captureDetails[i].assetLocationId,
        captureDetails[i].itemId,
        transactions[0].id,
        captureDetails[i].color,
        captureDetails[i].height,
        captureDetails[i].length,
        captureDetails[i].width,
      ];

      sheet.importList(list, i+2, 1, false);}
    final bytes = woe.saveAsStream();
    woe.dispose();

    final path = (await getApplicationSupportDirectory()).path;
    final filename = '$path/dgi.xlsx';
    final file = File(filename);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(filename);
  }

}
