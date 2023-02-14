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
import 'package:dropdown_search/dropdown_search.dart';
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
import '../Services/lightVerificaion_service.dart';
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
import '../model/asset.dart';
import '../model/description.dart';
import '../model/floor.dart';
import '../model/sectionType.dart';
import '../model/supplier.dart';

class LightVerificationScreen extends StatefulWidget {
  LightVerificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LightVerificationScreen> createState() =>
      _LightVerificationScreenState();
}

class _LightVerificationScreenState extends State<LightVerificationScreen> {
  bool isLoading = false;
  String? category;
  String? mainCategory;
  String? level;
  String? accountGroup;
  String? supplier;
  String? brand;
  String? color;
  String? item;
  String? floor;
  String? section;
  String? description;
  String? imagePath;
  bool isChangeColor = false;
  bool isNext = false;
  Item? selectedItem;
  PlatformFile? selectedFile;

  List<SectionType> sections = [];
  List<SectionType> sectionsPerFloor = [];
  List<Floor> floors = [];
  List<Category> categories = [];
  List<MainCategory> mainCategories = [];
  List<Level> levels = [];
  List<AccountGroup> accountGroups = [];
  List<Supplier> suppliers = [];
  List<Item> items = [];
  List<Asset> assets = [
    Asset(id: 1, image: null, isVerified: 0),
    Asset(id: 1, image: null, isVerified: 0),
  ];
  List<Description> allDescriptions = [];
  List<DescriptionLight> descriptions = [];
  List<Brand> brands = [];
  List<ItemColor> colors = [];
  List<Category> allCategories = [];
  List<AccountGroup> allAccountGroups = [];
  List<MainCategory> allMainCategories = [];
  List<Item> allItems = [];
  List<int> assetIDs = [];

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
  final lightVerificationService = LightVerificationService();
  DateTime ownDate = DateTime.now();
  DateTime serviceDate = DateTime.now();
  DateTime creationDate = DateTime.now();
  List<CaptureDetails> captureDetails = [];

  TextEditingController quantityController = TextEditingController(text: "1");

  int currentPage = 1;
  int lastPage = 1;
  int? sectionId;
  bool isSelectedAll = false;
  bool loadPage = false;
  bool loadSection = false;

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
      item = null;
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
      item = null;
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
      item = null;
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
      item = null;
      description = null;
    });
  }

  changeItem(value) async {
    item = value;
    Item selected = items.firstWhere((element) => element.name == value);
    selectedItem = selected;
    print('selectedItem?.hasLength ${selectedItem?.hasHeight}');
    descriptions = await lightCaptureService.getAllDescriptions(selected.id);
    description = null;
    setState(() {});
  }

  changeFloor(value) async {
    floor = value;
    Floor selected = floors.firstWhere((element) => element.name == value);
    sectionsPerFloor = await lightCaptureService.getAllSections(selected.id!);
    section = null;
    setState(() {});
  }

  changeSection(value) async {
    section = value;
    sectionId = sections.firstWhere((sec) => sec.name == value).id;
    try{
    setState(() => loadSection = true);
    await lightVerificationService.downloadAssets(1, sectionId!);
    currentPage = 1;
    lastPage = 1;
    paginateAsset.clear();
    paginateAsset.addEntries([MapEntry(1, LightVerificationService.assets)]);
    setState(() => loadSection = false);
    }catch(error){
      CustomWidgetBuilder.showMessageDialog(context, error.toString(), true);
      setState(() => loadSection = false);
    }
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

    return Scaffold(
      body: loadSection
          ? CustomWidgetBuilder.buildSpanner()
          : SafeArea(
              child: Container(
                height: dSize.height - bottomPadding,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Counting Transaction',
                      style: TextStyle(
                          color: Color(0xFF01B3C0),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: dSize.width * 0.5,
                                child: DropdownSearch<String>(
                                  popupProps: const PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true),
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      isDense: true,
                                      hintText: "Username",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  items: floors
                                      .map((e) => e.name)
                                      .toSet()
                                      .toList(),
                                  onChanged: changeFloor,
                                  selectedItem: floor,
                                ),
                              ),
                              SizedBox(
                                width: dSize.width * 0.5,
                                child: DropdownSearch<String>(
                                  popupProps: const PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true),
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      isDense: true,
                                      hintText: "Building",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  items: floors
                                      .map((e) => e.name)
                                      .toSet()
                                      .toList(),
                                  onChanged: changeFloor,
                                  selectedItem: floor,
                                ),
                              ),
                              SizedBox(
                                width: dSize.width * 0.5,
                                child: DropdownSearch<String>(
                                  popupProps: const PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true),
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10),
                                      isDense: true,
                                      hintText: "Unit",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  items: sections
                                      .map((e) => e.name)
                                      .toSet()
                                      .toList(),
                                  onChanged: changeSection,
                                  selectedItem: section,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset('assets/icons/scan.png'),
                              Text(
                                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                              Image.asset('assets/icons/scan.png'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF4FB7BE),
                      thickness: 1.5,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Assets Quantity'),
                              Text('${LightVerificationService.totalRecords}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Number of pages'),
                              Text(
                                  '$currentPage/${LightVerificationService.totalPages}'),
                            ],
                          ),
                          CheckboxListTile(
                            title: const Text("Select all", style: TextStyle(color: Color(0xFF007C6D)),),
                            value: isSelectedAll,
                            onChanged: (newValue) {
                              if(paginateAsset.isNotEmpty){
                                isSelectedAll = newValue!;
                                print(newValue);
                                paginateAsset[currentPage]!
                                    .forEach((e)  {
                                  print(e.isVerified);
                                      isSelectedAll
                                          ? e.isVerified = 1
                                          : e.isVerified = 0;
                                      print(e.isVerified);
                                    });
                              }
                              setState(() {});
                            },
                            // controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            side: MaterialStateBorderSide.resolveWith(
                                  (states) => const BorderSide(width: 1.0, color: Color(0xFF01B3C0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Expanded(
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomWidgetBuilder.buildArrow(context, dSize,
                              const Icon(Icons.arrow_back_ios_rounded), () {
                            setState(() {
                              if (currentPage > 1) {
                                currentPage--;
                                paginateAsset[currentPage]!.every((element) => element.isVerified == 1) ?
                                    isSelectedAll = true : isSelectedAll = false;
                              }
                            });
                          }),
                          isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  child: const Text(
                                    'Done',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () => {upload()},
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFF00B0BD),
                                      textStyle: const TextStyle(fontSize: 20),
                                      padding: const EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      minimumSize: Size(dSize.width * 0.3, 34)),
                                ),
                          loadPage
                              ? const CircularProgressIndicator()
                              : CustomWidgetBuilder.buildArrow(
                                  context,
                                  dSize,
                                  const Icon(Icons.arrow_forward_ios),
                                  sectionId != null ? () => nextPage() : null),
                        ],
                      ),
                    ),
                  ],
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
        'Barcode',
        'Desc Name',
        'Photo',
        'Done',
      ], isHeader: true),
    );
    if (paginateAsset.isNotEmpty) {
      for (i = 0; i < paginateAsset[currentPage]!.length; i++) {
        listings.add(
          CustomWidgetBuilder.lightVerificationTable(
            [
              Column(
                children: [
                  Image.asset('assets/icons/scan.png'),
                  Text('${paginateAsset[currentPage]![i].barcode}')
                ],
              ),
              paginateAsset[currentPage]![i].description,
              paginateAsset[currentPage]![i] == null ||
                      paginateAsset[currentPage]![i].image == null
                  ? Image.asset(
                      'assets/icons/img.png',
                      fit: BoxFit.cover,
                      width: 300,
                    )
                  : Image.memory(
                      base64Decode(paginateAsset[currentPage]![i].image!),
                      width: 300,
                      height: 100,
                    ),
              checkbox(i),
            ],
          ),
        );
      }
    }
    return listings;
  }

  Widget checkbox(int i) {
    return Transform.scale(
      scale: 1.7,
      child: Checkbox(
        value: paginateAsset[currentPage]![i].isVerified == 0 ||
                paginateAsset[currentPage]![i].isVerified == null
            ? false
            : true,
        onChanged: (val) {
          setState(() {});
          paginateAsset[currentPage]![i].isVerified = val! ? 1 : 0;
        },
        side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(width: 1.0, color: Color(0xFF01B3C0)),
        ),
      ),
    );
  }

  void initData() async {
    levels = await levelService.retrieve();
    allAccountGroups = await accountGroupService.retrieve();
    suppliers = await supplierService.retrieve();
    allMainCategories = await mainCategoryService.retrieve();
    allCategories = await categoryService.retrieve();
    sections = LightVerificationService.severSections;
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

  List<Floor> getFloorsSuggestion(String query) {
    return floors.where((e) {
      final nameLower = e.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  List<SectionType> getSectionsSuggestion(String query) {
    return sectionsPerFloor.where((e) {
      final nameLower = e.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  List<DescriptionLight> getDescriptionsSuggestion(String query) {
    return descriptions.where((e) {
      final nameLower = e.description.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }

  getSectionsByFloor() async {
    section = null;
    final floorId = floors.firstWhere((element) => element.name == floor).id;

    sectionsPerFloor = await lightCaptureService.getAllSections(floorId!);

    setState(() {});
  }

  upload() async {
    for (var v in paginateAsset.values) {
      for (var asset in v) {
        if (asset.isVerified == 1) {
          assetIDs.add(asset.id);
        }
      }
    }
    if (section == null) {
      CustomWidgetBuilder.showMessageDialog(
          context, lang.getTxt('validation'), true);
    } else if(assetIDs.isEmpty){
      CustomWidgetBuilder.showMessageDialog(
          context, 'No selection items', true);
    }
    else {
      if (paginateAsset.isNotEmpty) {
        print(paginateAsset.values);
      }
      try {
        setState(() => isLoading = true);
        bool isSuccess =
            await lightVerificationService.uploadToServer(assetIDs);
        if (isSuccess) {
          showSuccessDialog();
          resetData();
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

  void resetData() {
    LightVerificationService.totalRecords -= assetIDs.length;
    print(LightVerificationService.totalRecords);
    assetIDs.clear();
    for (var i = 0; i < paginateAsset.length; i++) {
      paginateAsset[i + 1]!.removeWhere((asset) => asset.isVerified == 1);
    }
  }

  void nextPage() async {
    try{
    if (currentPage == lastPage) {
      if (lastPage < LightVerificationService.totalPages) {
        lastPage++;
        setState(() => loadPage = true);
        await lightVerificationService.downloadAssets(lastPage, sectionId!);
        paginateAsset
            .addEntries([MapEntry(lastPage, LightVerificationService.assets)]);
      }
    }
    if (currentPage < paginateAsset.length) {
      if(paginateAsset[currentPage + 1] == null || paginateAsset[currentPage + 1]!.isEmpty) return;
      currentPage++;
      paginateAsset[currentPage]!.every((element) => element.isVerified == 1) ?
      isSelectedAll = true : isSelectedAll = false;
    }
    setState(() => loadPage = false);
  }catch(error){
  CustomWidgetBuilder.showMessageDialog(context, error.toString(), true);
  setState(() => loadSection = false);
  }
  }

  Map<int, List<Asset>> paginateAsset = {};
}
