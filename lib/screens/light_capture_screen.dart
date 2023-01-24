import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/CaptureDetailsService.dart';
import 'package:dgi/Services/ColorService.dart';
import 'package:dgi/Services/ItemService.dart';
import 'package:dgi/Services/MainCategoryService.dart';
import 'package:dgi/Services/ServerService.dart';
import 'package:dgi/Utility/footer.dart';
import 'package:dgi/Utility/utilityService.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:dgi/model/brand.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/CaptureDetails.dart';
import 'package:dgi/model/itemColor.dart';
import 'package:dgi/model/item.dart';
import 'package:dgi/model/level.dart';
import 'package:dgi/model/mainCategory.dart';
import 'package:dgi/screens/home_page.dart';
import 'package:dgi/screens/take_picture_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Services/AccountGroupService.dart';
import '../Services/BrandService.dart';
import '../Services/DescriptionService.dart';
import '../Services/LevelService.dart';
import '../Services/SupplierService.dart';
import '../Services/lightCapture_service.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../Utility/dateRow.dart';
import '../Utility/dropDownMenuRow.dart';
import '../Utility/inputRow.dart';
import '../Utility/nextPageHeader.dart';
import '../Utility/quantityRow.dart';
import '../Utility/takeFileRow.dart';
import '../Utility/takePhotoRow.dart';
import '../db/captureLight.dart';
import '../language.dart';
import '../model/accountGroup.dart';
import '../model/description.dart';
import '../model/floor.dart';
import '../model/sectionType.dart';
import '../model/supplier.dart';

class LightCaptureScreen extends StatefulWidget {
  LightCaptureScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LightCaptureScreen> createState() => _LightCaptureScreenState();
}

class _LightCaptureScreenState extends State<LightCaptureScreen> {
  bool isLoading = false;
  String? category;
  String? mainCategory;
  String? level;
  String? accountGroup;
  String? supplier;
  String? brand;
  String? description;
  String? color;
  TextEditingController? item = TextEditingController();
  String? imagePath;
  bool isChangeColor = false;
  bool isNext = false;
  Item? selectedItem;
  PlatformFile? selectedFile;
  String? section;
  String? floor;

  List<SectionType> sections = [];
  List<SectionType> sectionsPerFloor = [];
  List<Floor> floors = [];
  List<Category> categories = [];
  List<MainCategory> mainCategories = [];
  List<Level> levels = [];
  List<AccountGroup> accountGroups = [];
  List<Supplier> suppliers = [];
  List<Item> items = [];
  List<Description> allDescriptions = [];
  List<DescriptionLight> descriptions = [];
  List<Brand> brands = [];
  List<ItemColor> colors = [];
  List<Category> allCategories = [];
  List<AccountGroup> allAccountGroups = [];
  List<MainCategory> allMainCategories = [];
  List<Item> allItems = [];

  final noteController = TextEditingController();
  final serialNoController = TextEditingController();
  final heightController = TextEditingController();
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final transRefController = TextEditingController();
  final transBordController = TextEditingController();
  final transCreationController = TextEditingController();
  final transTypeController = TextEditingController();
  final transHiekelController = TextEditingController();
  final transMamshaController = TextEditingController();
  final ajhezaController = TextEditingController();
  final assetBvalueController = TextEditingController();
  final costController = TextEditingController();
  final consumptionController = TextEditingController();
  final productionAgeController = TextEditingController();
  final splierNameController = TextEditingController();
  final codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final categoryService = CategoryService();
  final levelService = LevelService();
  final accountGroupService = AccountGroupService();
  final supplierService = SupplierService();
  final brandService = BrandService();
  final colorService = ColorService();
  final captureDetailsService = CaptureDetailsService();
  final mainCategoryService = MainCategoryService();
  final serverService = ServerService();
  final itemService = ItemService();
  final descriptionService = DescriptionService();
  final lightCaptureService = LightCaptureService();
  int quantity = 1;
  DateTime ownDate = DateTime.now();
  DateTime serviceDate = DateTime.now();
  DateTime creationDate = DateTime.now();
  List<CaptureDetails> captureDetails = [];

  final lang = Language();

  @override
  void initState() {
    super.initState();
    initData();
  }

  changeCategory(value) {
    setState(() {
      category = value;
      Category selected =
          categories.firstWhere((element) => element.name == category);
      accountGroups = allAccountGroups
          .where((element) => element.categoryId == selected.id)
          .toList();
      accountGroup = null;
      item!.text = '';
      description = null;
    });
  }

  changeMainCategory(value) {
    setState(() {
      mainCategory = value;
      MainCategory selected =
          mainCategories.firstWhere((element) => element.name == mainCategory);
      categories = allCategories
          .where((element) => element.mainCategoryId == selected.id)
          .toList();
      category = null;
      accountGroup = null;
      item!.text = '';
      description = null;
    });
  }

  changeLevel(value) {
    setState(() {
      level = value;
      Level selected = levels.firstWhere((element) => element.name == level);
      mainCategories = allMainCategories
          .where((element) => element.levelId == selected.id)
          .toList();
      mainCategory = null;
      category = null;
      accountGroup = null;
      item!.text = '';
    });
  }

  changeAccountGroup(value) {
    setState(() {
      accountGroup = value;
      AccountGroup selected =
          accountGroups.firstWhere((element) => element.name == accountGroup);
      items = allItems
          .where((element) => element.accountGroupId == selected.id)
          .toList();
      item!.text = '';
      description = null;
    });
  }

  changeItem(value) async {
    item!.text = value;
    Item selected = items.firstWhere((element) => element.name == value);
    selectedItem = selected;
    print('selectedItem?.hasLength ${selectedItem?.hasHeight}');
    descriptions = await lightCaptureService.getAllDescriptions(selected.id);
    description = null;
    setState(() {});
  }

  changeBrand(value) {
    setState(() {
      brand = value;
    });
  }

  changeDescription(value) {
    setState(() {
      description = value;
    });
  }

  changeColor(value) {
    setState(() {
      color = value;
    });
  }

  changeSupplier(value) {
    setState(() {
      supplier = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.top;

    final firstPageHeight =
        dSize.height < 600 ? dSize.height * 0.59 : dSize.height * 0.73;
    final secondPageHeight =
        dSize.height < 600 ? dSize.height * 0.40 : dSize.height * 0.51;

    List<Widget> firstPage = [
      Row(
        children: [
          CustomWidgetBuilder.buildText(lang.getTxt('floor'), dSize),
          Spacer(),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFF00B0BD), width: 2))),
            width: dSize.width * 0.5,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: floor,
                iconSize: 20,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF00B0BD),
                ),
                isDense: true,
                isExpanded: true,
                items: floors
                    .map((e) => e.name)
                    .toSet()
                    .toList()
                    .map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                          color: Color(0xFF0F6671), fontSize: 15),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    floor = val;
                  });
                  getSectionsByFloor();
                  print('-----${sectionsPerFloor.length}------');
                },
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          CustomWidgetBuilder.buildText(lang.getTxt('section'), dSize),
          Spacer(),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFF00B0BD), width: 2))),
            width: dSize.width * 0.5,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: section,
                iconSize: 20,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF00B0BD),
                ),
                isDense: true,
                isExpanded: true,
                items: sectionsPerFloor
                    .map((e) => e.name)
                    .toSet()
                    .toList()
                    .map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                          color: Color(0xFF0F6671), fontSize: 15),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    section = val;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          CustomWidgetBuilder.buildText('ITEMS', dSize),
          Spacer(),
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFF00B0BD), width: 2))),
            width: dSize.width * 0.5,
            child: TypeAheadField<Item>(
              textFieldConfiguration: TextFieldConfiguration(
                  style: TextStyle(
                      fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
                  controller: this.item,
                  decoration: InputDecoration(
                    constraints:
                        const BoxConstraints(minHeight: 2, maxHeight: 30),
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF00B0BD),
                      size: 20,
                    ),
                    contentPadding: EdgeInsets.all(
                        dSize.height <= 600 ? dSize.height * 0.015 : 4),
                    isDense: true,
                    border: InputBorder.none,
                  )),
              suggestionsCallback: getItemsSuggestion,
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(
                    suggestion.name,
                    style:
                        const TextStyle(color: Color(0xFF0F6671), fontSize: 15),
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                changeItem(suggestion.name);
              },
            ),
          ),
        ],
      ),
      // if (item!.text.isNotEmpty)
      DropDownMenuRow(
          title: lang.getTxt('description'),
          dSize: dSize,
          values: descriptions.map((e) => e.description).toSet().toList(),
          onChange: changeDescription,
          value: description),
      // DropDownMenuRow(
      //     title: lang.getTxt('brand'),
      //     dSize: dSize,
      //     values: brands.map((e) => e.name).toSet().toList(),
      //     onChange: changeBrand,
      //     value: brand),
      // DropDownMenuRow(
      //     title: lang.getTxt('color'),
      //     dSize: dSize,
      //     values: colors.map((e) => e.name).toSet().toList(),
      //     onChange: changeColor,
      //     value: color),
      // InputRow(
      //     title: lang.getTxt('note'), dSize: dSize, controller: noteController),
      // InputRow(
      //     title: lang.getTxt('code'), dSize: dSize, controller: codeController),

      // DateRow(
      //   title: lang.getTxt('own_date'),
      //   dSize: dSize,
      //   date: ownDate,
      //   function: () {
      //     showDatePicker(
      //         context: context,
      //         initialDate: ownDate,
      //         firstDate: DateTime(DateTime.now().year - 5),
      //         lastDate: DateTime(DateTime.now().year + 5))
      //         .then((date) {
      //       setState(() {
      //         ownDate = date!;
      //       });
      //     });
      //   },
      // ),
      // DateRow(
      //   title: lang.getTxt('service_date'),
      //   dSize: dSize,
      //   date: serviceDate,
      //   function: () {
      //     showDatePicker(
      //         context: context,
      //         initialDate: serviceDate,
      //         firstDate: DateTime(DateTime.now().year - 5),
      //         lastDate: DateTime(DateTime.now().year + 5))
      //         .then((date) {
      //       setState(() {
      //         serviceDate = date!;
      //       });
      //     });
      //   },
      // ),
      QuantityRow(
        title: lang.getTxt('quantity'),
        dSize: dSize,
        quantity: quantity,
        decreaseMethod: () {
          if (quantity > 1) {
            setState(() {
              quantity--;
            });
          }
        },
        increaseMethod: () {
          setState(() {
            quantity++;
          });
        },
      ),
      TakePhotoRow(
        title: lang.getTxt('photo'),
        dSize: dSize,
        imagePath: imagePath,
        function: _showCamera,
      ),
      // buildColorButton(),
    ];

    return Directionality(
      textDirection: Language.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: dSize.height - bottomPadding,
              child: Column(
                children: [
                  NextPageHeader(
                      dSize: dSize,
                      title: lang.getTxt('capture_header_title'),
                      subTitle: lang.getTxt('capture_header_subTitle')),
                  Container(
                    height: isNext ? null : firstPageHeight, // secondPageHeight
                    padding:
                        EdgeInsets.symmetric(horizontal: dSize.height * 0.016),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...firstPage,
                          isLoading ? CircularProgressIndicator() : ElevatedButton(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  fontSize: dSize.height <= 500
                                      ? dSize.height * 0.027
                                      : 13.75),
                            ),
                            onPressed: () => {upload()},
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xFFFFA227),
                                textStyle: const TextStyle(fontSize: 20),
                                padding: const EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                minimumSize: Size(dSize.width * 0.4, 34)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Footer()
                ],
              ),
            ),
          ),
        ),
      ),
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
      imagePath = result;
    });
  }

  _takeFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      selectedFile = result.files.first;
    });
  }

  void saveItem() async {
    if (noteController.text.isEmpty ||
        imagePath == null ||
        item == null ||
        description == null) {
      CustomWidgetBuilder.showMessageDialog(
          context, lang.getTxt('validation'), true);
    }
    // else if (!UtilityService.isNumeric(heightController.text) ||
    //     !UtilityService.isNumeric(widthController.text) ||
    //     !UtilityService.isNumeric(lengthController.text)) {
    //   CustomWidgetBuilder.showMessageDialog(
    //       context, lang.getTxt('validate_numbers'), true);
    // }
    else {
      try {
        File file = File(imagePath!);
        final Uint8List bytes = file.readAsBytesSync();
        String base64Image = base64Encode(bytes);

        String? base64File;
        if (selectedFile != null) {
          File file2 = File(selectedFile!.path!);
          final Uint8List? bytes2 = file2.readAsBytesSync();
          base64File = base64Encode(bytes2!);
        }

        String note = noteController.text;
        String? serialNumber;
        int? itemId =
            items.firstWhere((element) => element.name == item?.text).id;
        int? brandId = brands.firstWhere((element) => element.name == brand).id;
        int? descriptionId = descriptions
            .firstWhere((element) => element.description == description)
            .id;
        int? colorId = colors.firstWhere((element) => element.name == color).id;
        getItems();
        // delete file to avoid cash overload
        try {
          file.deleteSync();
        } catch (ex) {
          print(ex);
        }
      } catch (error) {
        CustomWidgetBuilder.showMessageDialog(context, error.toString(), true);
      }
    }
  }

  void getItems() async {
    captureDetailsService.retrieve().then((value) => {
          setState(() {
            captureDetails = value;
          })
        });
  }

  List<TableRow> _getListings() {
    List<TableRow> listings = <TableRow>[];
    int i = 0;
    listings.add(
      CustomWidgetBuilder.buildRow([
        lang.getTxt('no'),
        lang.getTxt('type'),
        lang.getTxt('note'),
        lang.getTxt('qnt_table'),
        lang.getTxt('photo')
      ], isHeader: true),
    );
    for (i = 0; i < captureDetails.length; i++) {
      listings.add(
        CustomWidgetBuilder.buildRow(
          [
            i + 1,
            allItems
                .firstWhere((element) => element.id == captureDetails[i].itemId)
                .name,
            captureDetails[i].description,
            captureDetails[i].quantity.toString(),
            Image.memory(
              base64Decode(captureDetails[i].image),
              height: 40,
              fit: BoxFit.fill,
            )
          ],
        ),
      );
    }
    return listings;
  }

  void initData() async {
    levels = await levelService.retrieve();
    allAccountGroups = await accountGroupService.retrieve();
    suppliers = await supplierService.retrieve();
    allMainCategories = await mainCategoryService.retrieve();
    allCategories = await categoryService.retrieve();
    floors = LightCaptureService.severFloors;
    items = LightCaptureService.severItems;
    allDescriptions = await descriptionService.retrieve();
    brands = await brandService.retrieve();
    colors = await colorService.retrieve();
    getItems();
    setState(() {});
  }

  List<Item> getItemsSuggestion(String query) {
    return items.where((e) {
      final nameLower = e.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  getSectionsByFloor() async {
    section = null;
    final floorId = floors.firstWhere((element) => element.name == floor).id;

    sectionsPerFloor = await lightCaptureService.getAllSections(floorId!);

    setState(() {
    });
  }

  upload() async {
    if (section == null ||
        floor == null ||
        item == null ||
        description == null) {
      CustomWidgetBuilder.showMessageDialog(
          context, lang.getTxt('validation'), true);
    } else {
      int? itemId =
          items.firstWhere((element) => element.name == item?.text).id;
      int? floorId = floors.firstWhere((element) => element.name == floor).id;
      int? sectionId =
          sectionsPerFloor.firstWhere((element) => element.name == section).id;
      int? descriptionId = descriptions
          .firstWhere((element) => element.description == description)
          .id;

      String? base64Image;
      if (imagePath != null) {
        File file = File(imagePath!);
        final Uint8List bytes = file.readAsBytesSync();
        base64Image = base64Encode(bytes);
      }
      try {
        setState(() => isLoading = true);
        bool isSuccess = await lightCaptureService.uploadToServer(CaptureLight(
            itemId: itemId,
            floorId: floorId,
            image: base64Image,
            quantity: quantity,
            description: description!,
            sectionId: sectionId,
            descriptionId: descriptionId,
            transactionId: 1));
        if(isSuccess) {
          showSuccessDialog();
          resetData();
          setState(() => isLoading = false);
        }
      } catch (error) {
        CustomWidgetBuilder.showMessageDialog(context, error.toString(), true);
      }
    }
  }

  void showSuccessDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: Text(lang.getTxt('successful_upload')),
          actions: [
            TextButton(
              child: Text(lang.getTxt('ok')),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
  }

  void resetData(){
    description = null;
    item?.text = '';
    quantity = 1;
    imagePath = null;
    descriptions = [];
  }
}
