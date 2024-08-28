// ignore_for_file: use_build_context_synchronously

import 'package:absensi_siswa/controller/user_controller.dart';
import 'package:absensi_siswa/view/detail_siswa.dart';
import 'package:flutter/material.dart';

import '../model/siswa_model.dart';
import '../widgets/base_components.dart';
import 'absensi_siswa.dart';
// import '../widgets/base_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Siswa>> siswa;

  UserController userController = UserController();

  // ignore: non_constant_identifier_names
  void FetchData() {
    siswa = userController.getSiswaList();
  }

  @override
  void initState() {
    super.initState();
    FetchData();
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
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: FutureBuilder<List<Siswa>>(
        future: siswa,
        builder: (context, snapshot) {
          final result = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (result.isNotEmpty) {
              return ListView.builder(
                itemCount: result.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = result[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailSiswa(
                          siswa: data,
                        ),
                      ));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      margin: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            minRadius: 10,
                            maxRadius: 12,
                            child: Text(
                              "${index + 1}",
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextTitle(
                                title: data.name.toUpperCase(),
                                align: TextAlign.left,
                                fontSize: 16,
                                weight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              TextTitle(
                                title: data.nim,
                                align: TextAlign.left,
                                fontSize: 12,
                                weight: FontWeight.w400,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: Text("No data"));
          }
          return const Center(child: Text("No data"));
        },
      ),
    );
  }
}
