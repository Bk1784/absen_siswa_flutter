import 'package:absen_mahasiswa2/models/students.dart';
import 'package:flutter/material.dart';

class AttendanceProvider with ChangeNotifier {
  final List<Student> _students = [
    Student(name: 'Ali'),
    Student(name: 'Budi'),
    Student(name: 'Citra'),
  ];
  final List<Map<String, dynamic>> _attendanceHistory = [];

  List<Student> get students => _students;
  List<Map<String, dynamic>> get attendanceHistory => _attendanceHistory;

  void toggleAttendance(int index) {
    _students[index].isPresent = !_students[index].isPresent;
    notifyListeners();
  }

// simpan status hadir ke riwayat
  void saveAttendance() {
    final timestamp = DateTime.now();
    final presentCount = _students.where((student) => student.isPresent).length;
    final absentCount = _students.length - presentCount;

    _attendanceHistory.insert(0, {
      'date': timestamp,
      'present': presentCount,
      'absent': absentCount
     
    });
    resetAttendance();
    notifyListeners();
  }

// reset status hadir siswa
  void resetAttendance() {
    for (var student in _students) {
      student.isPresent = false;
    }
  }
}
