import 'dart:developer';
import 'dart:io';

//import 'package:command_flutter/Payment/ex.dart';
import 'package:command_flutter/Payment/tinkoff.dart';
import 'package:command_flutter/Payment/tinkoff_sdk.dart';
import 'package:command_flutter/Styles/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scan_pay/qr_code_scan_pay.dart';
import 'package:sbp/data/asset_links_data.dart';
import 'package:sbp/data/c2bmembers_data.dart';
import 'package:sbp/models/application_info_model.dart';
import 'package:sbp/models/c2bmembers_model.dart';
import 'package:sbp/sbp.dart';
import 'package:url_launcher/url_launcher.dart';

String code = '';

class paymentPage extends StatefulWidget {
  // final url = 'https://qr.nspk.ru/AS10003P3RH0LJ2A9ROO038L6NT5RU1M?type=01&bank=000000000001&crc=F3D0'; // здесь нужно поменять qr-code как на примере: https://qr.nspk.ru/AS10003P3RH0LJ2A9ROO038L6NT5RU1M?type=01&bank=000000000001&sum=10000&cur=RUB&crc=F3D0
  final url =
      'https://sub.nspk.ru/BD100028ULC1S2R999G8I68UESGG5EAQ';
  final samUrl = 'https://invoicenpd.nalog.ru/?inn=370264753602&uuid=d5bb455b-b17e-46d2-a404-63fd875d5a56';
  const paymentPage({super.key});

  @override
  State<paymentPage> createState() => _paymentPageState();
}

class _paymentPageState extends State<paymentPage> {
  @override
  void initState() {
    super.initState();
    getInstalledBanks();
  }

  List<dynamic> informations = [];

  /// Получаем установленные банки
  Future<void> getInstalledBanks() async {
    try {
      if (Platform.isAndroid) {
        informations =
            await Sbp.getAndroidInstalledByAssetLinksJsonBanks(assetLinksData);
      }
      if (Platform.isIOS) {
        informations =
            await Sbp.getIOSInstalledByC2bmembersJsonBanks(c2bmembersData);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: purpleColor),
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    // isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (ctx) =>
                        SbpModalBottomSheetWidget(informations, widget.url),
                  ),
                  child: Text(
                    "Оплата по кнопке",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              // ),
              // Container(
              //   height: 100,
              //   width: 100,
              //   child: ElevatedButton(
              //       onPressed: () {
              //         Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => const QRViewExample(),
              //         ));
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: purpleColor,
              //       ),
              //       child: Text(
              //         "Оплата по QR-коду",
              //         textAlign: TextAlign.center,
              //       )),
              // )
            ],
          ),
          // if (code != null) Text(code!)
          // ElevatedButton(
          //   onPressed: () {
          //     launchUrl(Uri.parse(widget.samUrl));
          //   },
          //   child: Text("2 способ"),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (context) => ex2()));
          //   },
          //   child: Text("Пример3"),
          // ),
        ],
      ),
    );
  }
}
///////////////////////////////////////////////

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    // if(result != null){
    // code ='Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}';
    // Navigator.of(context).pop();
    // }
    bool clicked = false;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            if (result != null)
              Column(
                children: [
                  Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          result = null;
                        });
                      },
                      child: Text("Вернуться"))
                ],
              )
            else

              // Container(
              //   height: 400,
              //   width: 400,
              Expanded(
                child: Stack(
                  children: [
                    _buildQrView(context),
                    Positioned(
                      child: IconButton(
                        icon: Icon(
                          clicked == false ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          setState(() async {
                            if (clicked == false) {
                              print("Нажато");
                              clicked = true;
                            } else {
                              clicked = false;
                              print("опущено");
                            }
                          });
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            // ),
            // Container(
            // height: 100,
            // flex: 1,
            // child: FittedBox(
            //   fit: BoxFit.contain,
            // child: ListView(
            // children: <Widget>[
            // ElevatedButton(onPressed: (){
            //   Navigator.of(context).pop();
            // }, child: Text("Выйти")),
            // if (result != null)
            //   Text(
            //       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
            // else
            //   const Text('Scan a code'),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[
            //     Container(
            //       margin: const EdgeInsets.all(8),
            //       child: ElevatedButton(
            //           onPressed: () async {
            //             await controller?.toggleFlash();
            //             setState(() {});
            //           },
            //           child: FutureBuilder(
            //             future: controller?.getFlashStatus(),
            //             builder: (context, snapshot) {
            //               return Text('Flash: ${snapshot.data}');
            //             },
            //           )),
            //     ),
            //     Container(
            //       margin: const EdgeInsets.all(8),
            //       child: ElevatedButton(
            //           onPressed: () async {
            //             await controller?.flipCamera();
            //             setState(() {});
            //           },
            //           child: FutureBuilder(
            //             future: controller?.getCameraInfo(),
            //             builder: (context, snapshot) {
            //               if (snapshot.data != null) {
            //                 return Text(
            //                     'Camera facing ${describeEnum(snapshot.data!)}');
            //               } else {
            //                 return const Text('loading');
            //               }
            //             },
            //           )),
            //     )
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[
            //     Container(
            //       margin: const EdgeInsets.all(8),
            //       child: ElevatedButton(
            //         onPressed: () async {
            //           await controller?.pauseCamera();
            //         },
            //         child: const Text('pause',
            //             style: TextStyle(fontSize: 20)),
            //       ),
            //     ),
            //     Container(
            //       margin: const EdgeInsets.all(8),
            //       child: ElevatedButton(
            //         onPressed: () async {
            //           await controller?.resumeCamera();
            //         },
            //         child: const Text('resume',
            //             style: TextStyle(fontSize: 20)),
            //       ),
            //     )
            //   ],
            // ),
          ],
        ),
        // ),
        // )
        // ],
        // ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? MediaQuery.of(context).size.width
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    bool clicked = false;
    return Stack(
      children: [
        Center(
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 0,
                borderLength: 10,
                borderWidth: 5,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

///////////////////////////////////////////////
class SbpHeaderModalSheet extends StatelessWidget {
  const SbpHeaderModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          height: 5,
          width: 50,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/sbp.png',
          // width: 100,
          height: 80,
        ),
        const SizedBox(height: 10),
        const Text('Выберите банк для оплаты по СБП'),
        const SizedBox(height: 20),
      ],
    );
  }
}

class SbpModalBottomSheetEmptyListBankWidget extends StatelessWidget {
  const SbpModalBottomSheetEmptyListBankWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SbpHeaderModalSheet(),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Center(
                child: Text('У вас нет банков для оплаты по СБП'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}

/// Модальное окно с банками
class SbpModalBottomSheetWidget extends StatelessWidget {
  final List<dynamic> informations;
  final String url;

  const SbpModalBottomSheetWidget(this.informations, this.url, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// если есть информация о банках, то отображаем их
    if (informations.isNotEmpty) {
      return Column(
        children: [
          const SbpHeaderModalSheet(),
          Expanded(
            child: ListView.separated(
              itemCount: informations.length,
              itemBuilder: (ctx, index) {
                if (Platform.isAndroid) {
                  final information =
                      informations[index] as ApplicationInfoModel;
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      onTap: () =>
                          openAndroidBank(url, information.packageName),
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Image.memory(
                            information.bitmap!,
                            width: 80,
                          ),
                          const SizedBox(width: 20),
                          Center(
                            child: Text(information.name),
                          ),
                          const SizedBox(width: 10)
                        ],
                      ),
                    ),
                  );
                }
                final information = informations[index] as C2bmemberModel;
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => openIOSBank(url, information.schema),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: information.icon.isNotEmpty
                                ? Image.asset(
                                    information.icon,
                                  )
                                : Image.network(
                                    information.logoURL,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Center(
                          child: Text(information.bankName),
                        ),
                        const SizedBox(width: 10)
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 10),
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    } else {
      return const SbpModalBottomSheetEmptyListBankWidget();
    }
  }

  /// передается package_name
  Future<void> openAndroidBank(String url, String packageName) async =>
      await Sbp.openAndroidBank(url, packageName);

  /// передается scheme
  Future<void> openIOSBank(String url, String scheme) async =>
      await Sbp.openBankIOS(url, scheme);
}
