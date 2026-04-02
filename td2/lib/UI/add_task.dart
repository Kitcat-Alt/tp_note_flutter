import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../viewModel/TaskViewModel.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

final _formKey = GlobalKey<FormBuilderState>();

class AddTask extends StatelessWidget {
  final Task? task;
  const AddTask({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Center(
        child: FormBuilder(
          key: _formKey,
          initialValue: task != null ? {
            'name': task!.title,
            'description': task!.description,
            'difficulty': task!.difficulty.toDouble(),
          } : {},
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(labelText: 'Nom de tache'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(labelText: 'Description'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderSlider(
                name: 'difficulty',
                decoration: const InputDecoration(labelText: 'Difficultée'),
                initialValue: task != null ? task!.difficulty.toDouble() : 0.0,
                min: 0.0,
                max: 10.0,
                divisions: 10,
                displayValues: DisplayValues.all,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                color: Colors.lightGreen,
                textColor: Colors.black,
                padding: const EdgeInsets.all(8.0),
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final values = _formKey.currentState!.value;

                    String name = values['name'];
                    String description = values['description'];
                    int difficulty = (values['difficulty']).toInt();

                    if (task == null) {
                      Task newTask = Task.addTask(name, description, difficulty);
                      context.read<TaskViewModel>().addTask(newTask);
                    } else {
                      task!.title = name;
                      task!.description = description;
                      task!.difficulty = difficulty;
                      context.read<TaskViewModel>().updateTask(task!);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(task == null ? 'Add New Task' : 'Update Task'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
