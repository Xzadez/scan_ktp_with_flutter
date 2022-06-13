import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:profile_page/pages/profile_page.dart';
import 'package:profile_page/res/check.dart';
import 'package:profile_page/res/normalize.dart';
import 'package:profile_page/widgets/text_field.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key? key, this.imagePath}) : super(key: key);

  final String? imagePath;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late final TextDetectorV2 _textDetector;

  Size? _imageSize;

  String? _imgPath = '';

  String nikResult = "";
  String namaResult = "";
  String tempatLahirResult = "";
  String tglLahirResult = "";
  String jenisKelaminResult = "";
  String alamatFullResult = "";
  String alamatResult = "";
  String rtrwResult = "";
  String kelDesaResult = "";
  String kecamatanResult = "";
  String agamaResult = "";
  String statusKawinResult = "";
  String pekerjaanResult = "";
  String kewarganegaraanResult = "";

  List<TextElement> _elemets = [];

  Rect? nikRect;
  Rect? namaRect;
  Rect? tempatTanggalLahirRect;
  Rect? alamatRect;
  Rect? rtrwRect;
  Rect? kelDesaRect;
  Rect? kecamatanRect;
  Rect? jenisKelaminRect;
  Rect? agamaRect;
  Rect? statusKawinRect;
  Rect? pekerjaanRect;
  Rect? kewarganegaraanRect;

  TextEditingController nikController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController tmptTglLahirController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController alamatFullController = TextEditingController();
  TextEditingController agamaController = TextEditingController();
  TextEditingController perkawinanController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();
  TextEditingController kewarganegaraanController = TextEditingController();

  @override
  void initState() {
    _imgPath = widget.imagePath ?? '';
    _processImage();
    super.initState();
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  Future _processImage() async {
    _textDetector = GoogleMlKit.vision.textDetectorV2();
    _getImageSize(File(_imgPath ?? ''));
    final inputImage = InputImage.fromFile(File(_imgPath ?? ''));
    final text = await _textDetector.processImage(inputImage);

    for (final textBlock in text.blocks) {
      for (final textLine in textBlock.lines) {
        for (final textElemet in textLine.elements) {
          _elemets.add(textElemet);
          if (checkNikField(textElemet.text)) {
            nikRect = textElemet.rect;
          }

          if (checkNamaField(textElemet.text)) {
            namaRect = textElemet.rect;
            print('------name detected');
          }

          if (checkTglLahirField(textElemet.text)) {
            tempatTanggalLahirRect = textElemet.rect;
          }

          if (checkJenisKelaminField(textElemet.text)) {
            jenisKelaminRect = textElemet.rect;
          }

          if (checkAlamatField(textElemet.text)) {
            alamatRect = textElemet.rect;
            print("alamat field detected");
          }

          if (checkRtRwField(textElemet.text)) {
            rtrwRect = textElemet.rect;
            print("RT/RW field detected");
          }

          if (checkKelDesaField(textElemet.text)) {
            kelDesaRect = textElemet.rect;
            print("kelurahan / desa field detected");
          }

          if (checkKecamatanField(textElemet.text)) {
            kecamatanRect = textElemet.rect;
            print("kecamatan field detected");
          }

          if (checkAgamaField(textElemet.text)) {
            agamaRect = textElemet.rect;
            print("agama field detected");
          }

          if (checkKawinField(textElemet.text)) {
            statusKawinRect = textElemet.rect;
            print("statusKawin field detected");
          }

          if (checkPekerjaanField(textElemet.text)) {
            pekerjaanRect = textElemet.rect;
            print("pekerjaan field detected");
          }

          if (checkKewarganegaraanField(textElemet.text)) {
            kewarganegaraanRect = textElemet.rect;
            print("kewarganegaraan field detected");
          }
        }
      }
    }

    for (final textBlock in text.blocks) {
      for (final textLine in textBlock.lines) {
        if (isInside(textLine.rect, nikRect)) {
          nikResult = nikResult + ' ' + textLine.text;
          print(nikResult + ' nik');
        }

        if (isInside3Rect(
            isThisRect: textLine.rect,
            isInside: namaRect,
            andAbove: tempatTanggalLahirRect)) {
          if (textLine.text.toLowerCase() != "nama") {
            print("------ name");
            namaResult = (namaResult + " " + textLine.text).trim();
            print(namaResult);
          }
        }

        if (isInside(textLine.rect, tempatTanggalLahirRect)) {
          final temp = textLine.text.replaceAll("Tempat/Tgi Lahir", "");
          tempatLahirResult = temp.substring(0, temp.indexOf(',') + 1);
          print("------ tempat lahir");
          print(tempatLahirResult);
        }

        if (isInside(textLine.rect, tempatTanggalLahirRect)) {
          final temp = textLine.text.replaceAll("Tempat/Tgi Lahir", "");
          final result = temp.substring(0, temp.indexOf(',') + 1);
          print(result);
          if (result != null && result.isNotEmpty) {
            tglLahirResult =
                temp.replaceAll(result, "").replaceAll(":", "").trim();
          }

          print("------ tgllahir");
          print(tglLahirResult);
        }

        if (isInside(textLine.rect, jenisKelaminRect)) {
          jenisKelaminResult = jenisKelaminResult + " " + textLine.text;
          print("------ jenis kelamin ");
          print(jenisKelaminResult);
        }

        if (isInside3Rect(
            isThisRect: textLine.rect,
            isInside: alamatRect,
            andAbove: agamaRect)) {
          alamatFullResult = alamatFullResult + " " + textLine.text;
          print("------ alamat");
          print(alamatFullResult + 'asdasdasdasd');
        }

        if (isInside(textLine.rect, alamatRect)) {
          alamatResult = alamatResult + " " + textLine.text;
          print("------ alamat  ");
          print(alamatResult + 'result');
        }

        if (isInside(textLine.rect, rtrwRect)) {
          rtrwResult = rtrwResult + " " + textLine.text;
          print("------ rt rw ");
          print(rtrwResult);
        }

        if (isInside(textLine.rect, kelDesaRect)) {
          kelDesaResult = kelDesaResult + " " + textLine.text;
          print("------ keldesa");
          print(kelDesaResult);
        }

        if (isInside(textLine.rect, kecamatanRect)) {
          kecamatanResult = kecamatanResult + " " + textLine.text;
          print("------ kecamatan");
          print(kecamatanResult);
        }

        if (isInside(textLine.rect, agamaRect)) {
          agamaResult = agamaResult + " " + textLine.text;
          print("------ agama : $agamaResult");
        }

        if (isInside(textLine.rect, statusKawinRect)) {
          statusKawinResult = statusKawinResult + " " + textLine.text;
          print("------ status kawin result ");
          print(statusKawinResult);
        }

        if (isInside(textLine.rect, pekerjaanRect)) {
          pekerjaanResult = pekerjaanResult + " " + textLine.text;
          print("------ status pekerjaan result ");
          print(pekerjaanResult);
        }

        if (isInside(textLine.rect, kewarganegaraanRect)) {
          kewarganegaraanResult = kewarganegaraanResult + " " + textLine.text;
          print("------ status kewarganegaraan result ");
          print(kewarganegaraanResult);
        }
      }
    }
    setState(() {
      nikController.text = normalizeNikText(nikResult);
      namaController.text = normalizeNamaText(namaResult);
      tmptTglLahirController.text = tglLahirResult;
      jenisKelaminController.text =
          normalizeJenisKelaminText(jenisKelaminResult);
      alamatFullController.text = normalizeAlamatText(alamatFullResult);
      agamaController.text = normalizeAgamaText(agamaResult);
      perkawinanController.text = normalizeKawinText(statusKawinResult);
      pekerjaanController.text = normalizePekerjaanText(pekerjaanResult);
      kewarganegaraanController.text =
          normalizeKewarganegaraanText(kewarganegaraanResult);
    });

    print(normalizeNikText(nikResult));
    print(normalizeAlamatText(alamatFullResult) + 'asdajsbdjas');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Result Page'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // _imageSize != null
                //     ? Stack(
                //         children: [
                //           Container(
                //             child: CustomPaint(
                //               foregroundPainter:
                //                   TextDetectorPainter(_imageSize!, _elemets),
                //               child: AspectRatio(
                //                 aspectRatio: _imageSize!.aspectRatio,
                //                 child: Image.file(File(_imgPath!)),
                //               ),
                //             ),
                //           )
                //         ],
                //       )
                //     : Container(),
                TextFieldCustom(
                  title: 'NIK',
                  controller: nikController,
                ),
                TextFieldCustom(
                  title: 'Name',
                  controller: namaController,
                ),
                TextFieldCustom(
                  title: 'Tanggal Lahir',
                  controller: tmptTglLahirController,
                ),
                TextFieldCustom(
                  title: 'Jenis Kelamin',
                  controller: jenisKelaminController,
                ),
                TextFieldCustom(
                  title: 'Alamat',
                  controller: alamatFullController,
                  maxLines: 4,
                ),
                TextFieldCustom(
                  title: 'Agama',
                  controller: agamaController,
                ),
                TextFieldCustom(
                  title: 'Status Kawin',
                  controller: perkawinanController,
                ),
                TextFieldCustom(
                  title: 'Pekerjaan',
                  controller: pekerjaanController,
                ),
                TextFieldCustom(
                  title: 'Kewarganegaraan',
                  controller: kewarganegaraanController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: SizedBox(
                      height: Get.height / 14,
                      width: Get.width / 3.1,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Get.to(
                            ProfilePage(
                              nik: nikController.text,
                              nama: namaController.text,
                              tglLahir: tmptTglLahirController.text,
                              jenisKelamin: jenisKelaminController.text,
                              alamat: alamatFullController.text,
                              agama: agamaController.text,
                              statusKawin: perkawinanController.text,
                              pekerjaan: pekerjaanController.text,
                              kewarganegaraan: kewarganegaraanController.text,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextDetectorPainter extends CustomPainter {
  TextDetectorPainter(this.absoluteImageSize, this.elements);

  final Size absoluteImageSize;
  final List<TextElement> elements;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    Rect scaleRect(TextElement container) {
      return Rect.fromLTRB(
        container.rect.left * scaleX,
        container.rect.top * scaleY,
        container.rect.right * scaleX,
        container.rect.bottom * scaleY,
      );
    }

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 2.0;

    for (TextElement element in elements) {
      canvas.drawRect(scaleRect(element), paint);
    }
  }

  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return true;
  }
}
