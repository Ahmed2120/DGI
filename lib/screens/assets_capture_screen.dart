import 'package:dgi/Services/CategoryService.dart';
import 'package:dgi/Utility/DropDownMenu.dart';
import 'package:dgi/model/category.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssetsCapture extends StatefulWidget {
  const AssetsCapture({Key? key}) : super(key: key);

  @override
  State<AssetsCapture> createState() => _AssetsCaptureState();
}

class _AssetsCaptureState extends State<AssetsCapture> {
  CategoryService categoryService = CategoryService();
  List<String> categories = [];

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    initCategories();
  }


  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    print('hhh ${dSize.height * 0.004}');
    print('hhh ${dSize.width * 0.04}');
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: dSize.height - 24,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: dSize.height * 0.15,
                padding: EdgeInsets.symmetric(vertical: dSize.height * 0.015),
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
                    const Text(
                      'DGI ASSETS TRCKING',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(
                      height: dSize.height * 0.035,
                    ),
                    Row(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 25),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFA227),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12)),
                            ),
                            child: Text.rich(
                              TextSpan(
                                  style: TextStyle(
                                      fontSize: dSize.height * 0.028,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat'),
                                  children: const <InlineSpan>[
                                    TextSpan(
                                      text: 'ASSETS ',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'CAPTURE',
                                    ),
                                  ]),
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(dSize.height * 0.016),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropDownMenu(title: 'CATEGORY', values: categories),
                        Row(
                          children: [
                            const Text('ITEM DESC'),
                            Spacer(),
                            Container(
                              width: dSize.width * 0.4,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0xFF00B0BD), width: 2.0),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  constraints: BoxConstraints(maxHeight: dSize.height * 0.045),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('QUANTITY'),
                            Spacer(),
                            SizedBox(
                              width: dSize.width * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Color(0xFFFFA227),
                                    foregroundColor: Colors.white,
                                    radius: 12,
                                    child: Icon(Icons.remove),
                                  ),
                                  SizedBox(width: dSize.width * 0.0159,),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: dSize.height * 0.004, horizontal: dSize.width * 0.06),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF00B0BD), width: 2.0),
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Text('1', style: TextStyle(
                                        color: Color(0xFF0F6671), fontSize: dSize.width * 0.04, fontWeight: FontWeight.bold),),
                                  ),
                                  SizedBox(width: dSize.width * 0.0159,),
                                  const CircleAvatar(
                                    backgroundColor: Color(0xFF00B0BD),
                                    foregroundColor: Colors.white,
                                    radius: 12,
                                    child: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text('PHOTO'),
                            Spacer(),
                            SizedBox(
                              width: dSize.width * 0.4,
                              child: Image.asset('assets/icons/0-16.jpg', height: dSize.height * 0.055, alignment: Alignment.centerLeft,),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('ADD ', style:
                            const TextStyle(fontSize: 13, color: Color(0xFF0F6671), fontWeight: FontWeight.bold),),
                            Icon(Icons.add, size: 17, color: Color(0xFF00B0BD),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: dSize.height * 0.33,
                    child: ListView(
                      children: [
                        Table(
                          border: TableBorder(borderRadius: BorderRadius.circular(10)),
                          children: [
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO'], isHeader: true),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                            buildRow(['NO', 'TYPE', 'DESC', 'QTY', 'PHOTO']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('ITEM TOTAL     000', style: TextStyle(color: Color(0xFF0F6671), fontWeight: FontWeight.bold),), alignment: Alignment.centerLeft,),
                ],
              ),),
              Container(
                  width: double.infinity,
                  height: dSize.height * 0.07,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF26BB9B),
                            Color(0xFF00B0BD),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0, 1])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('USER NAME : MO GAMAL', style: TextStyle(color: Colors.white, fontSize: dSize.width * 0.037),),
                      Text('PDA NO : 1023088', style: TextStyle(color: Colors.white, fontSize: dSize.width * 0.037),),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    ));
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
    decoration: BoxDecoration(
      color: isHeader ? Color(0xFFFFA227) : Colors.grey[200],
        borderRadius: isHeader ? BorderRadius.circular(10) : BorderRadius.circular(0)
    ),
    children: cells.map((cell)=> Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(cell, style: TextStyle(color: isHeader ? Colors.white : Color(0xFF0F6671), fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),),
          )).toList(),
  );

  initCategories() async{
    CategoryService categoryService = CategoryService();
    Category category = Category(name: 'Category A');
    await categoryService.insert(category);
    category = Category(name: 'Category B');
    await categoryService.insert(category);
    category = Category(name: 'Category C');
    await categoryService.insert(category);
    category = Category(name: 'Category D');
    await categoryService.insert(category);
    categoryService.retrieve().then((result) => {
      setState(() {
        for(var item in result) {
          categories.add(item.name);
        }
      })
    });
  }
  
}
