import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/task_model.dart';
import '../../seervices/task_services.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TaskState> {
  String iscompleted(bool? compelet) {
    if (compelet == true) {
      return "colpleted";
    } else {
      return "not completed";
    }
  }

  TasksCubit() : super(TaskInitial()) {
    getTasks();
  }
  List<TaskModel> tasks = [];
  bool isLoading = true;
  getTasks() async {
    emit(TaskLoading());
    try {
      tasks = await TaskServices().getTasks();
      isLoading = false;
      emit(TaskSuccess());
    } catch (e) {
      print(e.toString());
      emit(TaskError());
    }
  }
}
