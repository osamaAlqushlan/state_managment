import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helloworld/views/tasks/tasks_cubit.dart';
import '../models/task_model.dart';
import '../seervices/task_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(),
      child: BlocBuilder<TasksCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskSuccess) {
            return Scaffold(
              body: ListView.builder(
                  itemCount: context.watch<TasksCubit>().tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text(context
                          .watch<TasksCubit>()
                          .tasks[index]
                          .id
                          .toString()),
                      title: Text(
                          context.watch<TasksCubit>().tasks[index].title ??
                              "--"),
                      subtitle: Text(context.watch<TasksCubit>().iscompleted(
                          context.watch<TasksCubit>().tasks[index].completed)),
                    );
                  }),
            );
          } else {
            return const Center(
              child: Text("Error in this screen"),
            );
          }
        },
      ),
    );
  }
}
