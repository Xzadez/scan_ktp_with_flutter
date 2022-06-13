import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:profile_page/pages/result_page.dart';
import 'package:profile_page/pages/scan_page.dart';
import 'package:profile_page/res/check.dart';

import '../main.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  CameraController? _controller;
  final TextDetector textDetector = GoogleMlKit.vision.textDetector();
  int _cameraIndex = 0;
  bool isBusy = false;

  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool check5 = false;
  bool check6 = false;
  bool check7 = false;
  bool check8 = false;

  double? _value = 0.0;

  double? _value1 = 0.0;
  double? _value2 = 0.0;
  double? _value3 = 0.0;
  double? _value4 = 0.0;
  double? _value5 = 0.0;
  double? _value6 = 0.0;
  double? _value7 = 0.0;
  double? _value8 = 0.0;
  double? _value9 = 0.0;
  double? _value10 = 0.0;
  double? _value11 = 0.0;
  double? _value12 = 0.0;

  bool isKtp = false;

  @override
  void initState() {
    super.initState();

    _startCamera();
  }

  @override
  void dispose() {
    _value = 0.0;
    super.dispose();
  }

  Future _startCamera() async {
    final camera = cameras![_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      _controller?.startImageStream(_processCameraImage);
    });
  }

  Future _processCameraImage(CameraImage cameraImage) async {
    final camera = cameras![_cameraIndex];
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in cameraImage.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
            InputImageFormat.NV21;

    final planeData = cameraImage.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    if (isBusy) return;
    isBusy = true;
    final recognisedText = await textDetector.processImage(inputImage);

    for (final textBlock in recognisedText.blocks) {
      for (final textLine in textBlock.lines) {
        for (final textElement in textLine.elements) {
          if (checkNikField(textElement.text)) {
            print('nik field detected');
            _value1 = 0.085;
          }

          if (checkNamaField(textElement.text)) {
            print('nama field detected');
            _value2 = 0.085;
          }

          if (checkTglLahirField(textElement.text)) {
            print('tempat/tgl lahir field detected');
            _value3 = 0.085;
          }

          if (checkJenisKelaminField(textElement.text)) {
            print('jenis kelamin field detected');
            _value4 = 0.085;
          }

          if (checkAlamatField(textElement.text)) {
            print('alamat field detected');
            _value5 = 0.085;
          }

          if (checkRtRwField(textElement.text)) {
            print('RT/RW field detected');
            _value6 = 0.085;
          }

          if (checkKelDesaField(textElement.text)) {
            print('Kel/Desa field detected');
            _value7 = 0.085;
          }

          if (checkKecamatanField(textElement.text)) {
            print('kecamatan field detected');
            _value8 = 0.085;
          }

          if (checkAgamaField(textElement.text)) {
            print('agama field detected');
            _value9 = 0.085;
          }

          if (checkKawinField(textElement.text)) {
            print('status kawin field detected');
            _value10 = 0.085;
          }

          if (checkPekerjaanField(textElement.text)) {
            print('pekerjaan field detected');
            _value11 = 0.085;
          }

          if (checkKewarganegaraanField(textElement.text)) {
            print('kewarganegaraan field detected');
            _value12 = 0.085;
          }

          // if (check1 == true &&
          //     check2 == true &&
          //     check3 == true &&
          //     check4 == true &&
          //     check5 == true &&
          //     check6 == true &&
          //     check7 == true &&
          //     check8 == true) {
          //   isKtp = true;
          // }

          // if (_value! >= 0.581) {
          //   isKtp = true;
          // }
        }
      }
      _value = _value1! +
          _value2! +
          _value3! +
          _value4! +
          _value5! +
          _value6! +
          _value7! +
          _value8! +
          _value9! +
          _value10! +
          _value11! +
          _value12!;

      if (_value! >= 0.595) {
        isKtp = true;
      }
      print(check1.toString() + 'check1');
      print(isKtp.toString() + 'ktp');
    }

    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<XFile> takePicture() async {
    XFile? file = await _controller?.takePicture();
    return file!;
  }

  Future<void> onShot() async {
    await Future.delayed(const Duration(milliseconds: 600));
    await _controller!.stopImageStream();
    await Future.delayed(const Duration(milliseconds: 200));
    _controller!.setFlashMode(FlashMode.off);
    XFile file = await takePicture();
    await Get.off(ResultPage(
      imagePath: file.path,
    ));

    await _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(_controller!),
              Positioned(
                bottom: 340,
                right: 50,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.45)),
                  ),
                  width: 70,
                  height: 105,
                ),
              ),
              Positioned(
                bottom: 320,
                right: 50,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.45)),
                  ),
                  width: 50,
                  height: 20,
                ),
              ),
              Center(
                child: Container(
                  width: size.width / 1.2,
                  height: size.height / 3.5,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 150,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    value: _value,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 80,
                child: FloatingActionButton(
                  backgroundColor: isKtp == true ? Colors.blue : Colors.grey,
                  child: Icon(
                    Icons.camera_alt,
                    color: isKtp == true ? Colors.white : Colors.black,
                  ),
                  onPressed: isKtp == true
                      ? () {
                          onShot();
                        }
                      : () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
