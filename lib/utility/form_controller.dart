import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//T in dart: defined so that paxi tya kai na kai value ta auxa

abstract class FormController<T> extends AutoDisposeFamilyNotifier<T, T?> {
  @override
  T build(T? arg);

  update();

  handleSubmit(BuildContext context);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isValidated => formKey.currentState!.validate();

  resetForm() {
    formKey.currentState!.reset();
  }
}
