class ModelDb {
  final String hobiesName;
  final String description;
  final DateTime createdAt;
  bool isChecked;
  final bool reccurentTask;

  ModelDb({
    required this.hobiesName,
    required this.description,
    required this.createdAt,
    required this.isChecked,
    required this.reccurentTask,
  });
}

class DataDb {
  final List<ModelDb> _hobbies = [
    ModelDb(hobiesName: 'Lavage de visage', description: 'Routine de soins de la peau', createdAt: DateTime.now(), isChecked: false, reccurentTask: true),
    ModelDb(
      hobiesName: 'Lecture',
      description: 'Lire des livres de science-fiction',
      createdAt: DateTime.now(),
      isChecked: false,
      reccurentTask: true,
    ),
    ModelDb(
      hobiesName: 'Cuisine',
      description: 'Essayer de nouvelles recettes',
      createdAt: DateTime.now(),
      isChecked: false,
      reccurentTask: true,
    ),
    ModelDb(
      hobiesName: 'Jardinage',
      description: 'Cultiver des plantes et des légumes',
      createdAt: DateTime.now(),
      isChecked: false,
      reccurentTask: true,
    ),
    ModelDb(
      hobiesName: 'Yoga',
      description: 'Pratiquer le yoga pour la relaxation',
      createdAt: DateTime.now(),
      isChecked: false,
      reccurentTask: true,
    ),
    ModelDb(
      hobiesName: 'Méditation',
      description: 'Pratiquer la méditation pour le bien-être',
      createdAt: DateTime.now(),
      isChecked: false,
      reccurentTask: true,
    ),
    ModelDb(
      hobiesName: 'Jardinage',
      description: 'Cultiver des plantes et des légumes',
      createdAt: DateTime.now(),
      isChecked: false,
      reccurentTask: true,
    ),
  ];

  // Méthode pour ajouter un hobby
  void addHobby(ModelDb hobby) {
    _hobbies.add(hobby);
  }

  void updateHobby(ModelDb hobby) {
    final index = _hobbies.indexWhere((h) => h.createdAt == hobby.createdAt);
    if (index != -1) {
      _hobbies[index] = hobby;
    }
  }

  // Méthode pour récupérer tous les hobbies
  List<ModelDb> getHobbies() {
    return _hobbies;
  }
}