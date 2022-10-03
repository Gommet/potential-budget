
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models.dart';

class SubmitStep extends StatelessWidget {
  final GlobalKey<FormState> _formKey;

  const SubmitStep(this._formKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Validate will return true if the form is valid, or false if
          // the form is invalid.
          if (_formKey.currentState!.validate()) {
            // Process data.
            if (kDebugMode) {
              print(context.read<BudgetFormData>());
            }
          }
        },
        child: const Text('Submit'),
      ),
    );
  }
}
