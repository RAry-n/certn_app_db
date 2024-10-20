import 'package:certin/encryption_helper.dart';
import 'package:certin/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import 'generated/assets.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late double height;
  late double width;

  int checkStatus = 0;
  var checker = [1,1,1,1];
  late StateSetter DialogSet;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black45,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                child: Container(
                  height: height * 0.085,
                  width: width * 0.95,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(Assets.assetsLogo),
                    /*Text(
                  "CERT-N",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),*/
                  ),
                ),
              ),
              /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Divider(),
          ),*/
              Padding(
                padding:
                EdgeInsets.fromLTRB(height * 0.035, 15.0, height * 0.035, 0.0),
                child: Container(
                  height: height * 0.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.5),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: Colors.white,
                    ),
                    backgroundBlendMode: BlendMode.overlay,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20.0),
                              onTap: () {
                                print("SHOW TIME TILL LAST CHECK");
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(Assets.assetsChecks),
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "  TIME SINCE LAST CHECKS",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "1:03s",
                                              style: TextStyle(color: Colors.white),
                                            )),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: VerticalDivider(),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20.0),
                              onTap: () {
                                print("SHOW TIME TILL LAST CHECK");

                                EncryptionHelper helper = EncryptionHelper();
                                String k = helper.encryptData("data is good. data is big. we luv data.");
                                String k2 = helper.decryptData(k);
                                //var k2 = helper.decryptData("b3a81d61fd74e60922c4cebb4cb0619a32d2406af92002ad018c12c400106dd69e490b49f81864fce581812f4016c089");
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Image.asset(Assets.assetsWarning),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "POTENTIAL THREATS",
                                              style: TextStyle(color: Colors.red),
                                            )),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "2",
                                              style: TextStyle(color: Colors.red),
                                            )),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: height * 0.035, vertical: 20.0),
                child: Container(
                  height: height * 0.075,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      checkStatus == 0
                          ? Colors.green.withOpacity(0.5)
                          : (checkStatus == 1)
                          ? Colors.yellow.withOpacity(0.5)
                          : Colors.red.withOpacity(0.5),
                      checkStatus == 0
                          ? Colors.green.withOpacity(0.75)
                          : (checkStatus == 1)
                          ? Colors.yellow.withOpacity(0.75)
                          : Colors.red.withOpacity(0.75),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: checkStatus == 0
                          ? Colors.green
                          : (checkStatus == 1)
                          ? Colors.yellow
                          : Colors.red,
                    ),
                    backgroundBlendMode: BlendMode.overlay,
                  ),
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        checkStatus = 1;
                      });
                      await Future.delayed(Duration(seconds: 5));
                      setState(() {
                        checkStatus = 0;
                      });
                    },
                    borderRadius: BorderRadius.circular(20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              child: Lottie.asset(
                                  checkStatus == 0
                                      ? Assets.assetsChecked
                                      : Assets.assetsLoading,
                                  decoder: customDecoder,
                                  repeat: checkStatus == 0 ? false : true),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                            child: Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  checkStatus == 0
                                      ? "ALL CHECKS PASSED"
                                      : "RUNNING CHECKS....",
                                  style: TextStyle(
                                    color: checkStatus == 0
                                        ? Colors.green
                                        : (checkStatus == 1)
                                        ? Colors.yellow
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(75.0, 5.0, 75.0, 0.0),
                child: Container(
                  height: height * 0.055,
                  // color: Colors.green,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "TEST YOUR SECURITY",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.35),
                child: Divider(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  onTap: () async {
                                    //runChecks();

                                    //Navigator.pushReplacementNamed(context, '/home');
                                    Get.to(()=>const HomePage());
                                  },
                                  child: Container(
                                    height: height * 0.175,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.grey.withOpacity(0.1),
                                            Colors.grey.withOpacity(0.4)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                      borderRadius: BorderRadius.circular(20.0),
                                      backgroundBlendMode: BlendMode.overlay,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Image.asset(Assets.assetsDb),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Container(
                                              child: const Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 8.0, 8.0),
                                                child: Text(
                                                  "Fetch Data From DB",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w200),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  onTap: () {
                                    print("T2");
                                    runChecks();
                                  },
                                  child: Container(
                                    height: height * 0.175,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.grey.withOpacity(0.1),
                                            Colors.grey.withOpacity(0.4)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                      borderRadius: BorderRadius.circular(20.0),
                                      backgroundBlendMode: BlendMode.overlay,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Image.asset(
                                                    Assets.assetsAttack),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 8.0, 8.0),
                                                child: Text(
                                                  "Unauthorized Requests",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 20.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  onTap: () {
                                    print("T3");
                                    runChecks();
                                  },
                                  child: Container(
                                    height: height * 0.175,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.grey.withOpacity(0.1),
                                            Colors.grey.withOpacity(0.4)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                      borderRadius: BorderRadius.circular(20.0),
                                      backgroundBlendMode: BlendMode.overlay,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Image.asset(Assets.assetsBomb),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 8.0, 8.0),
                                                child: Text(
                                                  "Repeated Requests [DoS]",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w200),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 20.0),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.0),
                                  onTap: () {
                                    print("T4");
                                    runChecks();
                                  },
                                  child: Container(
                                    height: height * 0.175,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            Colors.grey.withOpacity(0.1),
                                            Colors.grey.withOpacity(0.4)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter),
                                      borderRadius: BorderRadius.circular(20.0),
                                      backgroundBlendMode: BlendMode.overlay,
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Image.asset(Assets.assetsLog),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    8.0, 0.0, 8.0, 8.0),
                                                child: Text(
                                                  "Fetch Database Logs",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w200),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhere(
            (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
      );
    });
  }

  runChecks() async
  {
    setState(() {
      checkStatus = 1;
    });
    var dialog = StatefulBuilder(
        builder: (context, StateSetter setter) {
          DialogSet = setter;
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20.0),
            ),
            elevation: 12,
            backgroundColor: Colors.black,
            child: Container(
              width: width * 0.75,
              height: height * 0.55,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(
                      25.0)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.035,
                        vertical: 20.0),
                    child: Container(
                      height: height * 0.075,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        /*color: checkStatus == 0
                                                      ? Colors.green
                                                      : (checkStatus == 1)
                                                      ? Colors.yellow
                                                      : Colors.red,*/
                        gradient: LinearGradient(colors: [
                          checkStatus == 0
                              ? Colors.green.withOpacity(0.5)
                              : (checkStatus == 1)
                              ? Colors.yellow.withOpacity(0.5)
                              : Colors.red.withOpacity(0.5),
                          checkStatus == 0
                              ? Colors.green.withOpacity(0.75)
                              : (checkStatus == 1)
                              ? Colors.yellow.withOpacity(0.75)
                              : Colors.red.withOpacity(0.75),
                        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        borderRadius: BorderRadius
                            .circular(20.0),
                        border: Border.all(
                          color: checkStatus == 0
                              ? Colors.green
                              : (checkStatus == 1)
                              ? Colors.yellow
                              : Colors.red,
                        ),
                        backgroundBlendMode: BlendMode
                            .overlay,
                      ),
                      child: InkWell(
                        onTap: () async {
                          setState(() {
                            checkStatus = 1;
                          });
                          await Future.delayed(
                              const Duration(seconds: 5));
                          setState(() {
                            checkStatus = 0;
                          });
                        },
                        borderRadius: BorderRadius
                            .circular(20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets
                                    .all(4.0),
                                child: Container(
                                  child: Lottie.asset(
                                      checkStatus == 0
                                          ? Assets
                                          .assetsChecked
                                          : Assets
                                          .assetsLoading,
                                      decoder: customDecoder,
                                      repeat: checkStatus ==
                                          0
                                          ? false
                                          : true),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets
                                    .fromLTRB(
                                    8.0, 8.0, 16.0,
                                    8.0),
                                child: Container(
                                  child: FittedBox(
                                    fit: BoxFit
                                        .contain,
                                    child: Text(
                                      checkStatus == 0
                                          ? "ALL CHECKS PASSED"
                                          : "RUNNING CHECKS....",
                                      style: TextStyle(
                                        color: checkStatus ==
                                            0
                                            ? Colors
                                            .green
                                            : (checkStatus ==
                                            1)
                                            ? Colors
                                            .yellow
                                            : Colors
                                            .red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //CHECK 1
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.035,
                        vertical: 5.0),
                    child: Container(
                      height: height * 0.075,
                      width: width * 0.5,
                      child: Row(
                        mainAxisSize: MainAxisSize
                            .max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets
                                  .all(4.0),
                              child: Container(
                                child: Lottie.asset(
                                    checker[0] == 0
                                        ? Assets
                                        .assetsChecked
                                        : Assets
                                        .assetsChecking,
                                    decoder: customDecoder,
                                    repeat: checker[0] ==
                                        0
                                        ? false
                                        : true),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets
                                  .fromLTRB(
                                  8.0, 8.0, 16.0,
                                  8.0),
                              child: Container(
                                child: FittedBox(
                                  fit: BoxFit
                                      .contain,
                                  child: Text(
                                    checker[0] == 0
                                        ? "CHECK 1 CLEARED"
                                        : "CHECK 1 RUNNING..",
                                    style: TextStyle(
                                      color: checker[0] ==
                                          0
                                          ? Colors
                                          .green
                                          : (checker[0] ==
                                          1)
                                          ? Colors
                                          .yellow
                                          : Colors
                                          .red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //CHECK 2
                  Visibility(
                    visible: checker[0]==0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: height * 0.035,
                          vertical: 5.0),
                      child: Container(
                        height: height * 0.075,
                        width: width * 0.5,
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets
                                    .all(4.0),
                                child: Container(
                                  child: Lottie.asset(
                                      checker[1] == 0
                                          ? Assets
                                          .assetsChecked
                                          : Assets
                                          .assetsChecking,
                                      decoder: customDecoder,
                                      repeat: checker[1] ==
                                          0
                                          ? false
                                          : true),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets
                                    .fromLTRB(
                                    8.0, 8.0, 16.0,
                                    8.0),
                                child: Container(
                                  child: FittedBox(
                                    fit: BoxFit
                                        .contain,
                                    child: Text(
                                      checker[1] == 0
                                          ? "CHECK 2 CLEARED"
                                          : "CHECK 2 RUNNING..",
                                      style: TextStyle(
                                        color: checker[1] ==
                                            0
                                            ? Colors
                                            .green
                                            : (checker[1] ==
                                            1)
                                            ? Colors
                                            .yellow
                                            : Colors
                                            .red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //CHECK 3
                  Visibility(
                    visible: checker[1]==0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: height * 0.035,
                          vertical: 5.0),
                      child: Container(
                        height: height * 0.075,
                        width: width * 0.5,
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets
                                    .all(4.0),
                                child: Container(
                                  child: Lottie.asset(
                                      checker[2] == 0
                                          ? Assets
                                          .assetsChecked
                                          : Assets
                                          .assetsChecking,
                                      decoder: customDecoder,
                                      repeat: checker[2] ==
                                          0
                                          ? false
                                          : true),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets
                                    .fromLTRB(
                                    8.0, 8.0, 16.0,
                                    8.0),
                                child: Container(
                                  child: FittedBox(
                                    fit: BoxFit
                                        .contain,
                                    child: Text(
                                      checker[0] == 0
                                          ? "CHECK 3 CLEARED"
                                          : "CHECK 3 RUNNING..",
                                      style: TextStyle(
                                        color: checker[2] ==
                                            0
                                            ? Colors
                                            .green
                                            : (checker[2] ==
                                            1)
                                            ? Colors
                                            .yellow
                                            : Colors
                                            .red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //CHECK 4
                  Visibility(
                    visible: checker[2]==0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: height * 0.035,
                          vertical: 5.0),
                      child: Container(
                        height: height * 0.075,
                        width: width * 0.5,
                        child: Row(
                          mainAxisSize: MainAxisSize
                              .max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets
                                    .all(4.0),
                                child: Container(
                                  child: Lottie.asset(
                                      checker[3] == 0
                                          ? Assets
                                          .assetsChecked
                                          : Assets
                                          .assetsChecking,
                                      decoder: customDecoder,
                                      repeat: checker[3] ==
                                          0
                                          ? false
                                          : true),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets
                                    .fromLTRB(
                                    8.0, 8.0, 16.0,
                                    8.0),
                                child: Container(
                                  child: FittedBox(
                                    fit: BoxFit
                                        .contain,
                                    child: Text(
                                      checker[3] == 0
                                          ? "CHECK 4 CLEARED"
                                          : "CHECK 4 RUNNING..",
                                      style: TextStyle(
                                        color: checker[3] ==
                                            0
                                            ? Colors
                                            .green
                                            : (checker[3] ==
                                            1)
                                            ? Colors
                                            .yellow
                                            : Colors
                                            .red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
    try {
      checker = [1,1,1,1];
      showDialog(
          context: context,
          builder: (context) {
            return dialog;
          });
      await Future.delayed(const Duration(seconds: 2));
      DialogSet(() {
        checker[0]=0;
        checker[1]=1;
      });
      print("CHECK 1 DONE");
      await Future.delayed(const Duration(seconds: 2));
      DialogSet(() {
        checker[1]=0;
        checker[2]=1;
      });
      print("CHECK 2 DONE");

      await Future.delayed(const Duration(seconds: 2));
      DialogSet(() {
        checker[2]=0;
        checker[3]=1;
      });
      print("CHECK 3 DONE");
      await Future.delayed(const Duration(seconds: 2));
      DialogSet(() {
        checker[3]=0;
        checkStatus = 0;
      });
      print("CHECK 4 DONE");

    }
    catch(e)
    {
      print("caught$e");
    }
    setState(() {
      checkStatus = 0;
    });

  }
}



