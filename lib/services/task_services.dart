import 'package:hobies_app/db/data_db.dart';

class TaskServices {
  DataDb dataDb = DataDb();

  Future<List<ModelDb>> getAllTask() async {
    return dataDb.getHobbies();
  }

  Future<void> addTask(ModelDb task) async {
    dataDb.addHobby(task);
  }

  Future<void> updateTask(ModelDb task) async {
    dataDb.updateHobby(task);
  }

  Future<void> deleteTask(ModelDb task) async {
    // Implement deletion logic if needed
  }

  Future<List<ModelDb>> getTaskCompleted() async {
    List<ModelDb> allTasks = dataDb.getHobbies();
    List<ModelDb> completedTasks = allTasks.where((task) => task.isChecked).toList();
    return completedTasks;
  }
}