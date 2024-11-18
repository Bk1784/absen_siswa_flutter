import 'package:absen_mahasiswa2/providers/attendance_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Riwayat Kehadiran'),
      ),
      body: attendanceProvider.attendanceHistory.isEmpty
          ? const Center(child: Text('Tidak ada riwayat kehadiran'))
          : ListView.builder(
              itemCount: attendanceProvider.attendanceHistory.length,
              itemBuilder: (context, index) {
                final history = attendanceProvider.attendanceHistory[index];
                final date = history['date'];
                final present = history['present'];
                final absent = history['absent'];

                // Format tanggal
                final formattedDate = "${date.day}/${date.month}/${date.year}";

                return ListTile(
                  title: Text("Tanggal: $formattedDate"),
                  subtitle: Text("Hadir: $present, Tidak Hadir: $absent"),
                );
              },
            ),
    );
  }
}
