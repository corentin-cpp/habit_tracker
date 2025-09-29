class Task {
  final int? id;
  final String name;
  final String description;
  final bool isChecked;
  final DateTime? executionDate;
  final DateTime createdAt;
  final bool reccurent;
  final String userId;

  Task({
    this.id,
    required this.name,
    required this.description,
    required this.isChecked,
    this.executionDate,
    required this.createdAt,
    required this.reccurent,
    required this.userId,
  });

  // Convertir depuis JSON (Supabase)
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      isChecked: json['isChecked'] ?? false,
      executionDate: json['executionDate'] != null 
          ? DateTime.parse(json['executionDate']) 
          : null,
      createdAt: DateTime.parse(json['created_at']),
      reccurent: json['reccurent'] ?? false,
      userId: json['user_id'] ?? '',
    );
  }

  // Convertir vers JSON (pour Supabase)
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'isChecked': isChecked,
      'executionDate': executionDate?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'reccurent': reccurent,
      'user_id': userId,
    };
  }

  // Créer une copie avec des modifications
  Task copyWith({
    int? id,
    String? name,
    String? description,
    bool? isChecked,
    DateTime? executionDate,
    DateTime? createdAt,
    bool? reccurent,
    String? userId,
  }) {
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isChecked: isChecked ?? this.isChecked,
      executionDate: executionDate ?? this.executionDate,
      createdAt: createdAt ?? this.createdAt,
      reccurent: reccurent ?? this.reccurent,
      userId: userId ?? this.userId,
    );
  }
}
