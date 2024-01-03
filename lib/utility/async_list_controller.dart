import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:traveltales/utility/repository.dart';

abstract class AsyncListController<T>
    extends AutoDisposeAsyncNotifier<List<T>> {
  @override
  FutureOr<List<T>> build() {
    return load();
  }

  final storage = GetStorage();

  Repository<T> get respository;

  /// flag for State Persistance
  bool useStorage = false;

  Future<List<T>> fetchData() async {
    final client = await ref.getDebouncedHttpClient();

    return await respository.fetch(client: client);
  }

  switchUseStorage() async {
    useStorage = !useStorage;
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => load());
  }

  /// Defines the value of key for read/write in storage
  final String key = "key";

  /// Method to convert json String into [List]
  List<T> fromStorage(String data);

  /// Method to convert current state [List] into json String
  String toStorage();

  /// Load state from storage using [key]
  Future<List<T>> load() async {
    if (useStorage) {
      final list = await storage.read(key);
      if (list != null) {
        return fromStorage(list);
      }
    } else {
      return fetchData();
    }

    return [];
  }

  /// Store current state into storage using [key]
  store() {
    if (useStorage) storage.write(key, toStorage());
  }

  bool get hasData => state.value != null;
  Future<void> add(T model) async {
    state = AsyncData([model, ...(state.value) ?? []]);
    store();
  }

  updateOne(int index, {required T model}) {
    if (hasData) {
      state = AsyncData([...state.value!..[index] = model]);
      store();
    }
  }

  removeAt(int index) {
    if (hasData) {
      state = AsyncData([...state.value!..removeAt(index)]);
    }
  }

  remove(T model) {
    if (hasData) {
      final index =
          state.value!.indexWhere((element) => findById(element, model));
      if (index != -1) {
        state = AsyncData([...state.value!..removeAt(index)]);
      }
    }
  }

  /// Condition for findById
  bool findById(T element, T current);

  /// Handles add or edit to list based on findById
  handleSubmit(T model) {
    if (hasData) {
      final index =
          state.value!.indexWhere((element) => findById(element, model));
      if (index == -1) {
        add(model);
      } else {
        updateOne(index, model: model);
      }
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
}

extension DebounceAndCancelExtension on Ref {
  /// Wait for [duration] (defaults to 500ms), and then return a [http.Client]
  /// which can be used to make a request.
  ///
  /// That client will automatically be closed when the provider is disposed.
  Future<http.Client> getDebouncedHttpClient([Duration? duration]) async {
    // First, we handle debouncing.
    var didDispose = false;
    onDispose(() => didDispose = true);

    // We delay the request by 500ms, to wait for the user to stop refreshing.
    await Future<void>.delayed(duration ?? const Duration(milliseconds: 1000));

    // If the provider was disposed during the delay, it means that the user
    // refreshed again. We throw an exception to cancel the request.
    // It is safe to use an exception here, as it will be caught by Riverpod.
    if (didDispose) {
      throw Exception('Cancelled');
    }

    // We now create the client and close it when the provider is disposed.
    final client = http.Client();
    onDispose(client.close);

    // Finally, we return the client to allow our provider to make the request.
    return client;
  }
}
