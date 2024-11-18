import 'package:absen_mahasiswa2/providers/attendance_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'attendance_history_screen.dart';  // Halaman Riwayat Kehadiran
      // Provider untuk manajemen kehadiran

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Menyimpan index tab yang aktif

  final List<Widget> _screens = [
    // Daftar halaman yang bisa dipilih pada BottomNavigationBar
    const AttendancePage(),  // Halaman Pencatatan Kehadiran
    const AttendanceHistoryScreen(),  // Halaman Riwayat Kehadiran
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Pencatatan Kehadiran'),
      ),
      body: _screens[_currentIndex],  // Menampilkan halaman yang dipilih
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,  // Menandakan halaman aktif
        onTap: (index) {
          setState(() {
            _currentIndex = index;  // Mengubah halaman saat tab dipilih
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Pencatatan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }
}

// Halaman Pencatatan Kehadiran
class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: attendanceProvider.students.length,
              itemBuilder: (context, index) {
                final student = attendanceProvider.students[index];
                return ListTile(
                  title: Text(student.name),
                  trailing: Checkbox(
                    value: student.isPresent,
                    onChanged: (_) => attendanceProvider.toggleAttendance(index),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();  // Menambahkan garis pemisah
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: attendanceProvider.students.isEmpty
                  ? null
                  : () {
                      attendanceProvider.saveAttendance();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Kehadiran disimpan!')),
                      );
                    },
              child: const Text('Simpan Kehadiran'),
            ),
          ),
        ],
      ),
    );
  }
}
