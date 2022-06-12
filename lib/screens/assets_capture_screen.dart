import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Services/CaptureDetailsService.dart';
import 'package:dgi/Services/ItemService.dart';
import 'package:dgi/Services/MainCategoryService.dart';
import 'package:dgi/Services/ServerService.dart';
import 'package:dgi/Utility/footer.dart';
import 'package:dgi/Utility/utilityService.dart';
import 'package:dgi/model/assetLocation.dart';
import 'package:dgi/model/brand.dart';
import 'package:dgi/model/category.dart';
import 'package:dgi/model/CaptureDetails.dart';
import 'package:dgi/model/item.dart';
import 'package:dgi/model/mainCategory.dart';
import 'package:dgi/screens/home_page.dart';
import 'package:dgi/screens/take_picture_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../Services/BrandService.dart';
import '../Services/DescriptionService.dart';
import '../Utility/CustomWidgetBuilder.dart';
import '../language.dart';
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
  String? brand;
  String? description;
  TextEditingController? item = TextEditingController();
  String? imagePath;
  bool isChangeColor = false;

  List<Category> categories = [];
  List<MainCategory> mainCategories = [];
  List<Item> items = [];
  List<Description> allDescriptions = [];
  List<Description> descriptions = [];
  List<Brand> brands = [];
  List<Category> allCategories = [];
  List<Item> allItems = [];

  final noteController = TextEditingController();
  final serialNoController = TextEditingController();
  final heightController = TextEditingController();
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final categoryService = CategoryService();
  final brandService = BrandService();
  final captureDetailsService = CaptureDetailsService();
  final mainCategoryService = MainCategoryService();
  final serverService = ServerService();
  final itemService = ItemService();
  final descriptionService = DescriptionService();
  int quantity = 1;
  List<CaptureDetails> captureDetails = [];
  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  final lang = Language();

  void changeColor(Color color) {
    isChangeColor = true;
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  changeCategory(value) {
    setState(() {
      category = value;
      Category selected =
          categories.firstWhere((element) => element.name == category);
      items = allItems
          .where((element) => element.categoryId == selected.id)
          .toList();
      item!.text = '';
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

  changeItem(value) {
    setState(() {
      item!.text = value;
      Item selected =
      items.firstWhere((element) => element.name == value);
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

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.top;
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
                    padding: EdgeInsets.symmetric(vertical: dSize.height * 0.007),
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
                              color: Colors.white,),
                        ),
                        SizedBox(
                          height: Language.isEn ? dSize.height * 0.03 : dSize.height * 0.012,
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
                                  borderRadius: Language.isEn ? const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12)) : const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomLeft: Radius.circular(12)),
                                ),
                                child: Text.rich(
                                  TextSpan(
                                      style: TextStyle(
                                          fontSize: dSize.height * 0.028,
                                          color: Colors.white,),
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: lang.getTxt('capture_header_title'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: lang.getTxt('capture_header_subTitle')
                                        ),
                                      ]),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: dSize.height < 600 ? dSize.height * 0.55 : dSize.height * 0.54,
                    padding:
                        EdgeInsets.symmetric(horizontal: dSize.height * 0.016),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dropdownMenu(
                              lang.getTxt('main_category'),
                              dSize,
                              mainCategories.map((e) => e.name).toSet().toList(),
                              changeMainCategory,
                              mainCategory),
                          if (mainCategory != null)
                            dropdownMenu(
                                lang.getTxt('category'),
                                dSize,
                                categories.map((e) => e.name).toSet().toList(),
                                changeCategory,
                                category),
                          if (category != null)
                          Row(
                            children: [
                              CustomWidgetBuilder.buildText('ITEMS', dSize),
                              Spacer(),
                              Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2))),
                                width: dSize.width * 0.5,
                                child: TypeAheadField<Item>(
                                  textFieldConfiguration: TextFieldConfiguration(
                                      style: TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
                                      controller: this.item,
                                      decoration: InputDecoration(
                                        constraints: const BoxConstraints(minHeight: 2, maxHeight: 30),
                                        suffixIcon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xFF00B0BD),
                                          size: 20,
                                        ),
                                        contentPadding: EdgeInsets.all(
                                            dSize.height <= 600
                                                ? dSize.height * 0.015
                                                : 4),
                                        isDense: true,
                                        border: InputBorder.none,
                                      )
                                  ),
                                  suggestionsCallback: getItemsSuggestion,
                                  itemBuilder: (context, suggestion) {
                                    return ListTile(
                                      title: Text(suggestion.name, style: const TextStyle(
                                          color: Color(0xFF0F6671),
                                          fontSize: 15),),
                                    );
                                  },
                                  onSuggestionSelected: (suggestion){
                                    changeItem(suggestion.name);
                                  },
                                ),
                              ),
                            ],
                          ),
                          if (item!.text.isNotEmpty)
                          dropdownMenu(
                              lang.getTxt('description'),
                              dSize,
                              descriptions.map((e) => e.description).toSet().toList(),
                              changeDescription,
                              description),
                          dropdownMenu(
                              lang.getTxt('brand'),
                              dSize,
                              brands.map((e) => e.name).toSet().toList(),
                              changeBrand,
                              brand),
                          Row(
                            children: [
                              CustomWidgetBuilder.buildText(lang.getTxt('note'), dSize),
                              Spacer(),
                              Container(
                                width: dSize.width * 0.5,
                                child: TextFormField(
                                  controller: noteController,
                                  style: TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2)),
                                    contentPadding: EdgeInsets.all(
                                        dSize.height <= 600
                                            ? dSize.height * 0.015
                                            : 6),
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     CustomWidgetBuilder.buildText('SERIAL NO', dSize),
                          //     Spacer(),
                          //     Container(
                          //       width: dSize.width * 0.5,
                          //       child: TextFormField(
                          //         controller: serialNoController,
                          //         style: const TextStyle(fontSize: 14),
                          //         decoration: InputDecoration(
                          //           enabledBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   color: Color(0xFF00B0BD), width: 2)),
                          //           focusedBorder: OutlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   color: Color(0xFF00B0BD), width: 2)),
                          //           contentPadding: EdgeInsets.all(
                          //               dSize.height <= 430
                          //                   ? dSize.height * 0.004
                          //                   : 4),
                          //           isDense: true,
                          //           border: InputBorder.none,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              CustomWidgetBuilder.buildText(lang.getTxt('width'), dSize),
                              Spacer(),
                              Container(
                                width: dSize.width * 0.5,
                                child: TextFormField(
                                  controller: widthController,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
                                  decoration: InputDecoration(
                                    hintText: lang.getTxt('hint_cm_label'),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2)),
                                    contentPadding: EdgeInsets.all(
                                        dSize.height <= 600
                                            ? dSize.height * 0.015
                                            : 6),
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomWidgetBuilder.buildText(lang.getTxt('height'), dSize),
                              Spacer(),
                              Container(
                                width: dSize.width * 0.5,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: heightController,
                                  style: TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
                                  decoration: InputDecoration(
                                    hintText: lang.getTxt('hint_cm_label'),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2)),
                                    contentPadding: EdgeInsets.all(
                                        dSize.height <= 600
                                            ? dSize.height * 0.015
                                            : 6),
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomWidgetBuilder.buildText(lang.getTxt('length'), dSize),
                              Spacer(),
                              Container(
                                width: dSize.width * 0.5,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: lengthController,
                                  style: TextStyle(fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.02),
                                  decoration: InputDecoration(
                                    hintText: lang.getTxt('hint_cm_label'),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF00B0BD), width: 2)),
                                    contentPadding: EdgeInsets.all(
                                        dSize.height <= 600
                                            ? dSize.height * 0.015
                                            : 6),
                                    isDense: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
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
                                          vertical: dSize.height * 0.001,
                                          horizontal: 22.919),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFF00B0BD),
                                              width: dSize.height >= 430
                                                  ? 1.5
                                                  : 0.5),
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                          buildColorButton(),
                          buildAddButton(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          height: dSize.height < 600
                              ? dSize.height * 0.18
                              : dSize.height * 0.18,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: ListView(
                              children: [
                                Table(
                                    border: TableBorder(
                                        borderRadius: BorderRadius.circular(10)),
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
                                fontSize: dSize.height <= 500 ? 10 : dSize.height * 0.014,
                                color: Color(0xFF0F6671),
                                fontWeight: FontWeight.bold),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ],
                    ),
                  ),
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
                      ],
                    ),
                  ),
                  Footer()
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
          backgroundColor: Colors.orangeAccent,
          child: Icon(
            Icons.home,
            color: Colors.white,
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
              Icon(
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

  buildColorButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton(
          onPressed: () {
            showColorPicker();
          },
          style: TextButton.styleFrom(
              padding: const EdgeInsets.all(5),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: const Size(5, 2)),
          child: Row(
            children: [
              Icon(
                Icons.color_lens_outlined,
                size: 17,
                color: Colors.orangeAccent,
              ),
              SizedBox(width: 5,),
              Text(
                lang.getTxt('choose_color'),
                style: TextStyle(
                    fontSize: 12, color:Color(0xFF0F6671) , fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

      ],
    );
  }

  void saveItem() async {
    if (noteController.text.isEmpty ||
        imagePath == null ||
        item == null||
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
      int? itemId = items.firstWhere((element) => element.name == item?.text).id;
      int? brandId = brands.firstWhere((element) => element.name == brand).id;
      int? descriptionId = descriptions.firstWhere((element) => element.description == description).id;
      final captureDetails = CaptureDetails(
        color: pickerColor.value.toString(),
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
      CustomWidgetBuilder.buildRow([lang.getTxt('no'), lang.getTxt('type'), lang.getTxt('note'), lang.getTxt('qnt_table'), lang.getTxt('photo')],
          isHeader: true),
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

  dropdownMenu(String title, Size dSize, List<String> values, Function onChange,
      String? value) {
    return Row(
      children: [
        CustomWidgetBuilder.buildText(title, dSize),
        Spacer(),
        Container(
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFF00B0BD), width: 2))),
          width: dSize.width * 0.5,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                value: value,
                iconSize: 20,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF00B0BD),
                ),
                isDense: true,
                isExpanded: true,
                items: values.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                          color: Color(0xFF0F6671), fontSize: 15),
                    ),
                  );
                }).toList(),
                onChanged: (val) => {onChange(val)}),
          ),
        ),
      ],
    );
  }

  Text buildText(String title, dSize) {
    return Text(
      title,
      style: TextStyle(
          fontSize: dSize.width * 0.03,
          color: Color(0xFF0F6671),
          fontWeight: FontWeight.bold),
    );
  }

  void resetForm() {
    quantity = 1;
    imagePath = null;
    noteController.text = "";
    serialNoController.text = "";
    isChangeColor = false;
    widthController.text="";
    heightController.text="";
    lengthController.text="";
    pickerColor = Color(0xff443a49);
    currentColor = Color(0xff443a49);
  }

  void initData() async {
    mainCategories = await mainCategoryService.retrieve();
    allCategories = await categoryService.retrieve();
    allItems = await itemService.retrieve();
    allDescriptions = await descriptionService.retrieve();
    brands = await brandService.retrieve();
    getItems();
    setState(() {});
  }

  showColorPicker() {
    // raise the [showDialog] widget
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(lang.getTxt('pick_color'),),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text(lang.getTxt('get_color'),),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  List<Item> getItemsSuggestion(String query) {
    return items.where((e) {
      final nameLower = e.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }
}
