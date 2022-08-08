import 'package:flutter/material.dart';
import 'package:trackhub/screen/home.dart';
import 'package:trackhub/widget/maincolor.dart';
class Onboarding extends StatelessWidget {


String tentang_dinas = '''
Dinas Perhubungan Kabupaten Banyuwangi merupakan salah satu dari susunan
perangkat daerah yang memiliki tugas yaitu melaksanakan segala urusan terkait
pemerintahan bidang perhubungan yang menjadi kewenangan daerah. Dalam
melaksanan tugas dan fungsinya Dinas Perhubungan memiliki susunan organisasi
yang di dalamnya terdapat bagian Bidang Perhubungan Laut, Udara dan
Perkeretaapian, dan Bidang Lalu Lintas dan Angkutan Jalan. Angkutan Jalan terbagi menjadi 2 yakni angkutan barang dan angkutan orang seperti Lin dan Taksi.
''';

String tentang_aplikasi = '''
Aplikasi ini merupakan gagasan inovasi dari Dinas Perhubungan yang memungkinkan sopir angkutan perkotaan untuk memberikan lokasi guna dilakukan monitoring oleh admin berdasarkan tracking, serta petugas terminal yang melakukan pendataan penumpang guna memberikan laporan jumlah penumpang kepada admin.
''';

String cara_traking = ''''
1. Buka halaman Tracking
2. Pada kotak kiri bawah, hidupkan tombol icon lokasi
3. Pastikan tombol berwarna hijau, dan Tracking sukses diaktifkan
4. Lakukan perjalanan dan hati-hati di jalan
''';

String cara_pendataan = '''
1. Buka halaman Pendataan
2. Pilih metode pendataan penumpang
3 
    a. Apabila menggunakan metode absen penumpang,
    b. Masukkan nama lengkap dan tanggal lahir penumpang, ketuk lanjut
    c. Pilih penumpang lalu ketuk absen, pendataan berhasil
4 
    a. Apabila menggunakan metode Scan QR,
    b. Arahkan kamera smartphone ke QR Code yang tertera pada kartu penumpang
    c. Pendataan berhasil
''';

String cara_petugas = '''

Tata Cara Melakukan Pendataan Penumpang oleh Petugas Terminal
1. Buka halaman Pendataan
2. Pilih trayek angkutan yang disertai nama sopir, pastikan plat nomor angkutan sesuai, lalu ketuk lanjutkan
3. Pilih metode pendataan penumpang
4. 
    a. Apabila menggunakan metode absen penumpang,
    b. Masukkan nama lengkap dan tanggal lahir penumpang, ketuk lanjut
    c. Pilih penumpang lalu ketuk absen, pendataan berhasil
5. 
    a. Apabila menggunakan metode Scan QR,
    b. Arahkan kamera smartphone ke QR Code yang tertera pada kartu penumpang
    c. Pendataan berhasil
''';

  @override

   Widget build(BuildContext context) {

    return Scaffold(
      
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: Column(
            children: [
              Center(
                child: Image.asset("assets/images/logo.png",width: 80)
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child : Text("Tentang Dinas Perhubungan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Maincolor.PrimaryColor),textAlign: TextAlign.center,),
              ),
              Text(tentang_dinas, textAlign: TextAlign.justify),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child : Text("Tentang Aplikasi", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Maincolor.PrimaryColor),textAlign: TextAlign.center,),
              ),
              Text(tentang_aplikasi, textAlign: TextAlign.justify),
              
              Container(margin: EdgeInsets.symmetric(vertical: 10),height: 1,color: Maincolor.PrimaryColor),

               Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child : Text("Tata Cara Mengaktifkan Tracking Angkutan oleh Sopir", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Maincolor.PrimaryColor),textAlign: TextAlign.center,),
              ),
              Text(cara_traking, textAlign: TextAlign.justify),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child : Text("Tata Cara Melakukan Pendataan Penumpang oleh Sopir", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Maincolor.PrimaryColor),textAlign: TextAlign.center,),
              ),
              Text(cara_pendataan, textAlign: TextAlign.justify),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child : Text("Tata Cara Mengaktifkan Pendataan Penumpang oleh Petugas Terminal", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Maincolor.PrimaryColor),textAlign: TextAlign.center,),
              ),
              Text(cara_petugas, textAlign: TextAlign.justify),


              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("Panduan aplikasi ini juga dapat dilihat di menu 'Tentang Aplikasi' pada halaman akun",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),),
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: FlatButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                    child: Text(
                      "Lanjut",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  color: Maincolor.PrimaryColor,
                  disabledColor: Colors.grey,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15)),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}