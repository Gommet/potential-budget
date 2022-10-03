import 'package:flutter/material.dart';
import '../models.dart';
import 'package:provider/provider.dart';

class GeneralAttributesStep extends StatelessWidget {
  const GeneralAttributesStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: generalAttributesSubForm(context),
    );
  }

  List<Widget> generalAttributesSubForm(BuildContext context) {
    return <Widget>[
      getBudgetField(context),
      const SizedBox(
        height: 40,
      ),
      const Text('Repetition'),
      getRepetitionField(context),
      const SizedBox(
        height: 40,
      ),
      descriptionField(context),
    ];
  }

  TextFormField descriptionField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Description',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        context.read<BudgetFormData>().setDescription(value);
        return null;
      },
    );
  }

  Column getRepetitionField(BuildContext context) {
    return Column(
      children: allTags
          .map(
            (e) => ListTile(
            title: Text(e.title),
            leading: Radio<TimeTagEnum>(
              value: e.timeTag,
              groupValue: context.watch<BudgetFormData>().timeTag,
              onChanged: (TimeTagEnum? value) {
                if (value != null) {
                  context.read<BudgetFormData>().setTimeTagEnum(value);
                }
              },
            )),
      )
          .toList(),
    );
  }

  TextFormField getBudgetField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Budget',
        hintText: 'Enter your budget',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        context.read<BudgetFormData>().setBudget(double.parse(value.replaceAll(",", ".")));
        return null;
      },
    );
  }
}
