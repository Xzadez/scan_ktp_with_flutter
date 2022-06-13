import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profile_page/pages/scan_page.dart';
import 'package:profile_page/views/profile_view.dart';
import 'package:profile_page/widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(
      {Key? key,
      this.nik,
      this.nama,
      this.tglLahir,
      this.jenisKelamin,
      this.alamat,
      this.agama,
      this.statusKawin,
      this.pekerjaan,
      this.kewarganegaraan})
      : super(key: key);
  final String? nik;
  final String? nama;
  final String? tglLahir;
  final String? jenisKelamin;
  final String? alamat;
  final String? agama;
  final String? statusKawin;
  final String? pekerjaan;
  final String? kewarganegaraan;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: size.width / 3.7,
                    height: size.height / 8,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(54),
                      ),
                    ),
                  ),
                ),
                ProfileView(
                  nik: widget.nik ?? '-',
                  nama: widget.nama ?? '-',
                  tglLahir: widget.tglLahir ?? '-',
                  jenisKelamin: widget.jenisKelamin ?? '-',
                  alamat: widget.alamat ?? '-',
                  agama: widget.agama ?? '-',
                  statusKawin: widget.statusKawin ?? '-',
                  pekerjaan: widget.pekerjaan ?? '-',
                  kewarganegaraan: widget.kewarganegaraan ?? '-',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: SizedBox(
                      height: size.height / 15,
                      width: size.width / 3.1,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Scan KTP',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )
                            // GoogleFonts.poppins(
                            //   fontSize: 18,
                            //   fontWeight: semiBold,
                            //   color: color,
                            // ),
                            ),
                        onPressed: () {
                          Get.to(ScanPage());
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
