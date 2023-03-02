import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dgi/model/asset.dart';
import 'package:flutter/material.dart';

import '../Services/lightVerificaion_service.dart';
import '../Utility/CustomWidgetBuilder.dart';
import 'take_picture_page.dart';

class EditPhotoScreen extends StatefulWidget {
  EditPhotoScreen({Key? key, required this.asset}) : super(key: key);
  Asset asset;

  @override
  State<EditPhotoScreen> createState() => _EditPhotoScreenState();
}

class _EditPhotoScreenState extends State<EditPhotoScreen> {

  String? imagePath;
  bool isLoading = false;

  final lightVerificationService = LightVerificationService();

  @override
  Widget build(BuildContext context) {
    return isLoading ? CustomWidgetBuilder.buildSpanner() : Scaffold(
      appBar: AppBar(
        title: const Text('Edit Photo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.asset.image == null
                  ? Image.asset(
                      'assets/icons/img.png',
                      fit: BoxFit.cover,
                      width: 300,
                    )
                  : imagePath == null ? Image.memory(
                      base64Decode(widget.asset.image!),
                      fit: BoxFit.cover,
                      width: 300,
                      height: 400,
                    ) : Image.memory(
                base64Decode(imagePath!),
                fit: BoxFit.cover,
                width: 300,
                height: 400,
              ),
              buildElevatedButton(context, 'Change Photo 📸', const Color(0xFF00B0BD), ()=>_showCamera()),
              buildElevatedButton(context, 'Update', const Color(0xFFFFA227), ()=> update()),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(BuildContext context, String title, Color color, Function function) {
    return ElevatedButton(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onPressed: () => function(),
            style: ElevatedButton.styleFrom(
                primary: color,
                textStyle: const TextStyle(fontSize: 20),
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                minimumSize: const Size(33, 34)),
          );
  }

  _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    setState(() {
      File file = File(result!);
      final Uint8List bytes = file.readAsBytesSync();
      String base64Image = base64Encode(bytes);
      imagePath = base64Image;
    });
  }

  void update() async{
    if(imagePath != null) {

      try {
        setState(() => isLoading = true);
        bool isSuccess =
            await lightVerificationService.updateAssetImage(widget.asset);
        if (isSuccess) {
          print('jkhzz');
          showSuccessDialog();
          widget.asset.image = imagePath;
          setState(() => isLoading = false);
        }
      } catch (error) {
        CustomWidgetBuilder.showMessageDialog(context, error.toString(), true);
        setState(() => isLoading = false);
      }
    }
  }

  void showSuccessDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('Photo Changed Successfully'),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                final nav = Navigator.of(context);
                nav.pop();
                nav.pop(widget.asset);
              },
            )
          ],
        ));
  }
}
