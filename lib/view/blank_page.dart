import 'package:absensi_siswa/controller/user_controller.dart';
import 'package:absensi_siswa/model/status_model.dart';
import 'package:flutter/material.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({super.key});

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  DateTime selectedDate = DateTime.now();
  Future<List<StatusSiswa>>? attendanceFuture;

  void _fetchAttendance() {
    // Panggil fungsi dengan tanggal dalam format yang sesuai
    setState(() {
      attendanceFuture = UserController().fetchAttendanceByDate(selectedDate);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchAttendance(); // Ambil data pada tanggal sekarang saat inisialisasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Absensi Siswa"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              onDateChanged: (DateTime newDate) {
                setState(() {
                  selectedDate = newDate;
                });
                _fetchAttendance(); // Ambil data baru ketika tanggal diubah
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<StatusSiswa>>(
              future: attendanceFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available.'));
                } else {
                  final attendances = snapshot.data!;
                  return ListView.builder(
                    itemCount: attendances.length,
                    itemBuilder: (context, index) {
                      final attendance = attendances[index];
                      return ListTile(
                        title: Text(attendance.name),
                        subtitle: Text('NIM: ${attendance.nim}'),
                        trailing: Text(attendance.status),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
