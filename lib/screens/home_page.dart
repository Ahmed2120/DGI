import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dsize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xFF26BB9B),
                      Color(0xFF00B0BD),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 1])),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'HOME',
                    style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFA227),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                            child: const Text(
                          'DGI',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text('FIXED ASSET RACKING Software v 1.0.0', style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40)),
                    child: GridView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      children: [
                        buildColumn('Assets Capture', dsize, '1-15'),
                        buildColumn('Asset Movement Transaction', dsize, '1-13'),
                        buildColumn('Asset Verification', dsize, '1-12'),
                        buildColumn('View Assets by Location', dsize, '1-14'),
                        buildColumn('View Assets by Custodian', dsize, '1-16'),
                        buildColumn('Asset inquiry (Verified Asset)', dsize, '1-17'),
                      ],
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 130,
                        childAspectRatio: 2 / 1.71,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 20,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('FATS Dashboard', style: TextStyle(color: Color(0xFF0F6671), fontSize: 15, fontFamily: 'Montserrat')),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildColumn( String title, dsize, String img) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: double.infinity,
                            height: dsize.height * 0.11,
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.asset('assets/icons/$img.png'),
                          ),
                          Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
                        ],
                      );
  }
}
