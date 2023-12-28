import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:traveltales/features/auth/presentation/controller/auth_controller.dart';

abstract class ListController<T> extends Notifier<List<T>> {
  @override
  List<T> build() {
    return load();
  }

  /// flag for State Persistance
  bool useStorage = true;

  switchUseStorage() {
    useStorage = !useStorage;
    state = load();
  }

  /// Defines the value of key for read/write in storage
  final String key = "key";

  /// Method to convert json String into [List]
  List<T> fromStorage(String data);

  /// Method to convert current state [List] into json String
  String toStorage();

  /// Load state from storage using [key]
  List<T> load() {
    if (useStorage) {
      final list = storage.read(key);
      if (list != null) {
        return fromStorage(list);
      }
    }

    return [];
  }

  /// Store current state into storage using [key]
  store() {
    if (useStorage) storage.write(key, toStorage());
  }

  add(BuildContext context, {required T model}) {
    state = [...state..add(model)];
    store();
    showSnackBar(context, message: "Added Sucessfully");
  }

  update(BuildContext context, {required int index, required T model}) {
    state = [...state..[index] = model];
    store();
    showSnackBar(context, message: "Updated Sucessfully");
  }

  remove(BuildContext context, {int? index, T? model}) {
    if (index != null) {
      state = [...state..removeAt(index)];
    } else {
      final index = state.indexWhere((element) => findById(element, model!));
      if (index != -1) {
        state = [...state..removeAt(index)];
      }
    }
    store();
    showSnackBar(context, message: "Removed Sucessfully");
  }

  /// Condition for findById
  bool findById(T element, T current);

  /// Handles add or edit to list based on findById
  handleSubmit(BuildContext context, {required T model}) {
    final index = state.indexWhere((element) => findById(element, model));
    if (index == -1) {
      add(context, model: model);
    } else {
      update(context, index: index, model: model);
    }
  }

  /// Set the Form Widget
  Widget formWidget(T? model);

  /// Navigate to user form
  ///
  /// ```dart
  ///  model determines weather to show Add or Edit form
  ///  if(model==null) Add else Edit
  ///
  /// formWIdget is used as Widget
  /// ```
  ///
  void showForm(BuildContext context, {T? model}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => formWidget(model)));
  }

  showSnackBar(BuildContext context, {String message = "Snack Bar"}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
