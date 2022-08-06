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
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Services/AccountGroupService.dart';
import '../Services/BrandService.dart';
import '../Services/DescriptionService.dart';
import '../Services/LevelService.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../Utility/dropDownMenuRow.dart';
import '../Utility/inputRow.dart';
import '../language.dart';
import '../model/accountGroup.dart';
import '../model/description.dart';

class AssetsCapture extends StatefulWidget {
  final AssetLocation assetLocation;
  final int? departmentId;
  final int? sectionId;
  final int? floorId;

  AssetsCapture(
      {Key? key,
      required this.assetLocation,
      this.sectionId,
      this.floorId,
      this.departmentId})
      : super(key: key);

  @override
  State<AssetsCapture> createState() => _AssetsCaptureState();
}

class _AssetsCaptureState extends State<AssetsCapture> {
  String? category;
  String? mainCategory;
  String? level;
  String? accountGroup;
  String? brand;
  String? description;
  String? color;
  TextEditingController? item = TextEditingController();
  String? imagePath;
  bool isChangeColor = false;
  bool isNext = false;
  Item? selectedItem;

  List<Category> categories = [];
  List<MainCategory> mainCategories = [];
  List<Level> levels = [];
  List<AccountGroup> accountGroups = [];
  List<Item> items = [];
  List<Description> allDescriptions = [];
  List<Description> descriptions = [];
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
  final brandService = BrandService();
  final colorService = ColorService();
  final captureDetailsService = CaptureDetailsService();
  final mainCategoryService = MainCategoryService();
  final serverService = ServerService();
  final itemService = ItemService();
  final descriptionService = DescriptionService();
  int quantity = 1;
  DateTime acquisitionDate = DateTime.now();
  DateTime serviceDate = DateTime.now();
  List<CaptureDetails> captureDetails = [];

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  final lang = Language();

  // void changeColor(Color color) {
  //   isChangeColor = true;
  //   setState(() => pickerColor = color);
  // }

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
      item!.text = '';
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
    });
  }

  changeItem(value) {
    setState(() {
      item!.text = value;
      Item selected = items.firstWhere((element) => element.name == value);
      selectedItem = selected;
      descriptions = allDescriptions
          .where((element) => element.itemId == selected.id)
          .toList();
      description = null;
    });
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

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.top;

    final firstPageHeight =
        dSize.height < 600 ? dSize.height * 0.59 : dSize.height * 0.73;
    final secondPageHeight =
        dSize.height < 600 ? dSize.height * 0.40 : dSize.height * 0.51;

    List<Widget> itemType1 = [
      InputRow(
          title: 'AJEZATAMALOKNUMBER',
          dSize: dSize,
          controller: ajhezaController),
      InputRow(
          title: 'TRANSBORDNUMBER', dSize: dSize, controller: transBordController),
    ];

    List<Widget> itemType2 = [
      InputRow(
          title: 'TRANSREFNUMBER', dSize: dSize, controller: transRefController),
      InputRow(
          title: 'TRANSBORDNUMBER', dSize: dSize, controller: transBordController),
      InputRow(
          title: 'CREATIONNUMBER', dSize: dSize, controller: transCreationController),
      InputRow(title: 'TRANSTYPE', dSize: dSize, controller: transTypeController),
      InputRow(
          title: 'TRANSHIKELNUMBER', dSize: dSize, controller: transHiekelController),
      InputRow(title: 'TRANSMAMSHA', dSize: dSize, controller: transMamshaController),
    ];

    List<Widget> itemType3 = [
      InputRow(
          title: 'ASSET BOOK VALUE', dSize: dSize, controller: assetBvalueController),
    ];

    List<Widget> firstPage = [
      DropDownMenuRow(title: 'level', dSize: dSize, values: levels.map((e) => e.name).toSet().toList(),
          onChange: changeLevel, value: level),
      if (level != null)
        DropDownMenuRow(
            title: lang.getTxt('main_category'),
            dSize: dSize,
            values: mainCategories.map((e) => e.name).toSet().toList(),
            onChange: changeMainCategory,
            value: mainCategory),
      if (mainCategory != null)
        DropDownMenuRow(
            title: lang.getTxt('category'),
            dSize: dSize,
            values: categories.map((e) => e.name).toSet().toList(),
            onChange: changeCategory,
            value: category),
      if (category != null)
        DropDownMenuRow(
            title: 'account group',
            dSize: dSize,
            values: accountGroups.map((e) => e.name).toSet().toList(),
            onChange: changeAccountGroup,
            value: accountGroup),
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
      DropDownMenuRow(title: lang.getTxt('brand'), dSize: dSize,
          values: brands.map((e) => e.name).toSet().toList(), onChange: changeBrand, value: brand),
      DropDownMenuRow(title: lang.getTxt('color'), dSize: dSize,
          values: colors.map((e) => e.name).toSet().toList(), onChange: changeColor, value: color),
      InputRow(
          title: lang.getTxt('note'), dSize: dSize, controller: noteController),
      InputRow(
          title: lang.getTxt('code'), dSize: dSize, controller: codeController),
      InputRow(
        title: lang.getTxt('width'),
        dSize: dSize,
        controller: widthController,
        textType: TextInputType.number,
        hintText: lang.getTxt('hint_cm_label'),
      ),
      InputRow(
        title: lang.getTxt('height'),
        dSize: dSize,
        controller: heightController,
        textType: TextInputType.number,
        hintText: lang.getTxt('hint_cm_label'),
      ),
      InputRow(
        title: lang.getTxt('length'),
        dSize: dSize,
        controller: lengthController,
        textType: TextInputType.number,
        hintText: lang.getTxt('hint_cm_label'),
      ),
      Row(
        children: [
          CustomWidgetBuilder.buildText(lang.getTxt('Acquisition_date'), dSize),
          Spacer(),
          SizedBox(
            width: dSize.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: acquisitionDate,
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5))
                          .then((date) {
                        setState(() {
                          acquisitionDate = date!;
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.date_range,
                      color: Color(0xFF00B0BD),
                    )),
                CustomWidgetBuilder.buildText(
                    '${acquisitionDate.year} / ${acquisitionDate.month} / ${acquisitionDate.day}',
                    dSize),
              ],
            ),
          )
        ],
      ),
      Row(
        children: [
          CustomWidgetBuilder.buildText('SERVICE DATE', dSize),
          Spacer(),
          SizedBox(
            width: dSize.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: serviceDate,
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5))
                          .then((date) {
                        setState(() {
                          serviceDate = date!;
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.date_range,
                      color: Color(0xFF00B0BD),
                    )),
                CustomWidgetBuilder.buildText(
                    '${serviceDate.year} / ${serviceDate.month} / ${serviceDate.day}',
                    dSize),
              ],
            ),
          )
        ],
      ),
      Row(
        children: [
          CustomWidgetBuilder.buildText(lang.getTxt('quantity'), dSize),
          Spacer(),
          SizedBox(
            width: dSize.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color(0xFFFFA227),
                    foregroundColor: Colors.white,
                    radius: 10,
                    child: Icon(
                      Icons.remove,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: dSize.width * 0.0159,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: dSize.height * 0.001, horizontal: 22.919),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF00B0BD),
                          width: dSize.height >= 430 ? 1.5 : 0.5),
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(
                        color: Color(0xFF0F6671),
                        fontSize: 15.28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: dSize.width * 0.0159,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color(0xFF00B0BD),
                    foregroundColor: Colors.white,
                    radius: 10,
                    child: Icon(Icons.add, size: 20),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      Row(
        children: [
          CustomWidgetBuilder.buildText(lang.getTxt('photo'), dSize),
          const Spacer(),
          SizedBox(
            width: dSize.width * 0.5,
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    _showCamera();
                  },
                  child: imagePath == null
                      ? Image.asset(
                          'assets/icons/0-16.jpg',
                          height: dSize.height * 0.055,
                          alignment: Alignment.centerLeft,
                        )
                      : Image.file(
                          File(imagePath!),
                          height: dSize.height * 0.055,
                          alignment: Alignment.bottomLeft,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      // buildColorButton(),
    ];

    List<Widget> secondPage = [
      InputRow(title: 'COST', dSize: dSize, controller: costController),
      InputRow(title: 'CONSUMPTION', dSize: dSize, controller: consumptionController),
      InputRow(
          title: 'PRODUCTION AGE', dSize: dSize, controller: productionAgeController),
      InputRow(title: 'SPLIER NAME', dSize: dSize, controller: splierNameController),
      if (selectedItem?.itemType == 1) ...itemType1,
      if (selectedItem?.itemType == null) ...itemType2,
      if (selectedItem?.itemType == 3) ...itemType3,
      buildAddButton(),
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
                  Container(
                    width: double.infinity,
                    height: dSize.height * 0.132,
                    padding:
                        EdgeInsets.symmetric(vertical: dSize.height * 0.007),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF26BB9B),
                              Color(0xFF00B0BD),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0, 1])),
                    child: Column(
                      children: [
                        Text(
                          'DGI ASSETS TRACKING',
                          style: TextStyle(
                            fontSize: dSize.height * 0.027,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: Language.isEn
                              ? dSize.height * 0.03
                              : dSize.height * 0.012,
                        ),
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: dSize.height * 0.004,
                                    horizontal: 25),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFA227),
                                  borderRadius: Language.isEn
                                      ? const BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12))
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)),
                                ),
                                child: Text.rich(
                                  TextSpan(
                                      style: TextStyle(
                                        fontSize: dSize.height * 0.028,
                                        color: Colors.white,
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: lang
                                              .getTxt('capture_header_title'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                            text: lang.getTxt(
                                                'capture_header_subTitle')),
                                      ]),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: isNext ? secondPageHeight : firstPageHeight,
                    padding:
                        EdgeInsets.symmetric(horizontal: dSize.height * 0.016),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (!isNext) ...firstPage,
                          if (isNext) ...secondPage,
                        ],
                      ),
                    ),
                  ),
                  if (isNext)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: dSize.height < 600
                              ? dSize.height * 0.18
                              : dSize.height * 0.21,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ListView(
                              children: [
                                Table(
                                    border: TableBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    children: _getListings()),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            '${lang.getTxt('item_total')}     ${captureDetails.length}',
                            style: TextStyle(
                                fontSize: dSize.height <= 500
                                    ? 10
                                    : dSize.height * 0.014,
                                color: Color(0xFF0F6671),
                                fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ],
                    ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomWidgetBuilder.buildArrow(
                            context,
                            dSize,
                            Icon(Icons.arrow_back_ios_rounded),
                            () => Navigator.of(context).pop()),
                        CustomWidgetBuilder.nextAndBack(
                            nextFunction: () => setState(() {
                                  isNext = true;
                                }),
                            backFunction: () => setState(() {
                                  isNext = false;
                                })),
                      ],
                    ),
                  ),
                  Footer()
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: CustomWidgetBuilder.floatingActionButton(context),
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

  buildAddButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: Row(
            children: [
              Text(
                lang.getTxt('add'),
                style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF0F6671),
                    fontWeight: FontWeight.bold),
              ),
              const Icon(
                Icons.add,
                size: 17,
                color: Color(0xFF00B0BD),
              ),
            ],
          ),
          onPressed: () {
            saveItem();
          },
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(5),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(5, 2)),
        ),
      ],
    );
  }

  void saveItem() async {
    if (noteController.text.isEmpty ||
        imagePath == null ||
        item == null ||
        description == null) {
      CustomWidgetBuilder.showMessageDialog(
          context, lang.getTxt('validation'), true);
    } else if (!UtilityService.isNumeric(heightController.text) ||
        !UtilityService.isNumeric(widthController.text) ||
        !UtilityService.isNumeric(lengthController.text)) {
      CustomWidgetBuilder.showMessageDialog(
          context, lang.getTxt('validate_numbers'), true);
    } else if (!isChangeColor) {
      CustomWidgetBuilder.showMessageDialog(
          context, lang.getTxt('validate_color'), true);
    } else {
      File file = File(imagePath!);
      final Uint8List bytes = file.readAsBytesSync();
      String base64Image = base64Encode(bytes);
      String note = noteController.text;
      String? serialNumber;
      int? itemId =
          items.firstWhere((element) => element.name == item?.text).id;
      int? brandId = brands.firstWhere((element) => element.name == brand).id;
      int? descriptionId = descriptions
          .firstWhere((element) => element.description == description)
          .id;
      int? colorId = colors
          .firstWhere((element) => element.name == color)
          .id;
      final captureDetails = CaptureDetails(
        colorId: colorId,
        height: double.parse(heightController.text),
        width: double.parse(widthController.text),
        length: double.parse(lengthController.text),
        serialNumber: serialNumber,
        sectionId: widget.sectionId,
        floorId: widget.floorId,
        departmentId: widget.departmentId,
        brandId: brandId,
        descriptionId: descriptionId,
        assetLocationId: widget.assetLocation.id,
        itemId: itemId,
        description: note,
        image: base64Image,
        quantity: quantity,
        code: codeController.text,
        ajehzaTamolkNumber: ajhezaController.text,
        cost: costController.text,
        productionAge: int.parse(productionAgeController.text),
        accumulatedConsumption: consumptionController.text,
        transRefNumber: transRefController.text,
        transBoardNumber: transBordController.text,
        transHiekelNumbe: transHiekelController.text,
        transCreationDate: transCreationController.text,
        transMamsha: transMamshaController.text,
        transType: transTypeController.text,
        supplierName: splierNameController.text,
        assetBookValue: assetBvalueController.text,
      );
      print(captureDetails.toMap());
      captureDetailsService.insert(captureDetails);
      getItems();
      resetForm();
      // delete file to avoid cash overload
      try {
        file.deleteSync();
      } catch (ex) {
        print(ex);
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

  void resetForm() {
    quantity = 1;
    imagePath = null;
    noteController.text = "";
    serialNoController.text = "";
    isChangeColor = false;
    widthController.text = "";
    heightController.text = "";
    lengthController.text = "";
    pickerColor = Color(0xff443a49);
    currentColor = Color(0xff443a49);
  }

  void initData() async {
    levels = await levelService.retrieve();
    allAccountGroups = await accountGroupService.retrieve();
    allMainCategories = await mainCategoryService.retrieve();
    allCategories = await categoryService.retrieve();
    allItems = await itemService.retrieve();
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
}
