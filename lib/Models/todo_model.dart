class Todo {
  int? id; 
  String title; 
  String subtitle; 
  String description; 
  int? priority;
  String date;
  String date2;
  String time;
  bool isCompleted;

  Todo({
    this.id, // Konstruktor untuk membuat objek Todo
    required this.title,
    required this.subtitle,
    required this.description, 
    required this.priority, 
    required this.date, 
    required this.date2, 
    required this.time,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    // Fungsi untuk mengonversi objek Todo menjadi peta (Map) yang sesuai dengan database
    return {
      'id': id, // ID tugas
      'title': title, // Judul tugas
      'subtitle': subtitle, // Subjudul tugas
      'description': description, // Deskripsi tugas
      'priority': priority, // Prioritas tugas
      'date': date, // Tanggal tugas
      'date2': date2,
      'time': time,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

}
