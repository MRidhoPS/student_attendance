import 'package:absensi_siswa/controller/user_controller.dart';
import 'package:absensi_siswa/model/status_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home.dart';

class AbsensiSiswa extends StatefulWidget {
  const AbsensiSiswa({super.key});

  @override
  State<AbsensiSiswa> createState() => _AbsensiSiswaState();
}

class _AbsensiSiswaState extends State<AbsensiSiswa> {
  DateTime selectedDate = DateTime.now();
  late Future<List<StatusSiswa>> attendanceFuture;

  // Fetch attendance data
  void _fetchAttendance() {
    // Format tanggal dengan benar sebelum mengirim ke API
    final formattedDate = _formatDate(selectedDate);
    if (kDebugMode) {
      print("Fetching attendance for date: $formattedDate");
    } // Log untuk memastikan format benar
    attendanceFuture = UserController().fetchAttendanceByDate(formattedDate);
    setState(() {}); // Refresh UI
  }

  // Fungsi untuk memformat tanggal
  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  @override
  void initState() {
    super.initState();
    // Langsung fetch attendance ketika halaman diinisialisasi
    attendanceFuture =
        UserController().fetchAttendanceByDate(_formatDate(selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                "HomePage",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const AbsensiSiswa(),
                  ),
                  (route) => false,
                );
              },
              child: const Text("Absensi"),
            )
          ],
        ),
      ),
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
                  return const Center(child: Text('No data available.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available.'));
                } else {
                  final attendances = snapshot.data!;
                  return ListView.builder(
                    itemCount: attendances.length,
                    itemBuilder: (context, index) {
                      final attendance = attendances[index];
                      return Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.amber),
                        child: ListTile(
                          title: Text(
                            attendance.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            'NIM: ${attendance.nim}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          trailing: Text(
                            attendance.status,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white),
                          ),
                        ),
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
