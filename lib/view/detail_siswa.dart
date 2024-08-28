// ignore_for_file: use_build_context_synchronously

import 'package:absensi_siswa/controller/user_controller.dart';
import 'package:absensi_siswa/view/home.dart';
import 'package:absensi_siswa/widgets/base_components.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

import '../model/absen_model.dart';
import '../model/siswa_model.dart';

class DetailSiswa extends StatefulWidget {
  const DetailSiswa({super.key, required this.siswa});

  @override
  State<DetailSiswa> createState() => _DetailSiswaState();

  final Siswa siswa;
}

class _DetailSiswaState extends State<DetailSiswa> {
  UserController userController = UserController();

  String? selectedStatus;
  final List<String> statusOptions = ['Masuk', 'Izin', 'Bolos'];

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  Future<void> _submitAbsen() async {
    if (selectedStatus != null) {
      // Membuat objek Attendance dengan format tanggal yang benar
      final attendance = Attendance(
        studentId: widget.siswa.id,
        date: formatDate(DateTime.now()), // Format tanggal ke 'YYYY-MM-DD'
        // date: '2024-09-01',
        status: selectedStatus!,
      );

      try {
        await userController.postAbsen(attendance);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Absen berhasil disimpan')),
        );

        // Kembali ke HomePage
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
      } catch (e) {
        // Tangani error jika data sudah ada atau error lainnya
        if (e.toString().contains('Absen sudah dilakukan untuk hari ini')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Absen sudah dilakukan untuk hari ini')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Anda Sudah absen di tanggal ini')),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih status')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Absen Siswa"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.only(left: 30, right: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama Murid: ${widget.siswa.name.toUpperCase()}",
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              Text(
                "Nim Murid: ${widget.siswa.nim}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: 2)
                ),
                width: 150,
                child: Center(
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    dropdownColor: Colors.white,
                    value: selectedStatus,
                    hint: const Text('Pilih Status', style: TextStyle(fontWeight: FontWeight.w500),),
                    items: statusOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: _submitAbsen,
                child: const ButtonContainer(
                  width: 2,
                  height: 15,
                  color: Colors.blue,
                  opacity: 1,
                  radiusCircular: 10,
                  title: "Absen",
                  sizeFont: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
