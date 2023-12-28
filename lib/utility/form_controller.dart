import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//T in dart: defined so that paxi tya kai na kai value ta auxa

abstract class FormController<T> extends AutoDisposeFamilyNotifier<T, T?> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isValidated => formKey.currentState!.validate();

  FormState get formState => formKey.currentState!;
  @override
  T build(T? arg);

  update();

  handleSubmit(BuildContext context);

  resetForm() {
    formKey.currentState!.reset();
  }
}

/// Abstract class to define AutoDisposableFamilyAsyncNotifier Controller
abstract class AsyncFormController<T>
    extends AutoDisposeFamilyAsyncNotifier<T, T> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool get isValidated => formKey.currentState!.validate();
  FormState get formState => formKey.currentState!;
  @override
  FutureOr<T> build(T? arg);
  updateState();
  handleSubmit(BuildContext context);
}
