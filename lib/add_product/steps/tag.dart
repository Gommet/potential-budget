
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../models.dart';

class TagStep extends StatelessWidget {
  const TagStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.select((BudgetFormData e) => e.tag.created)) {
      return Column(
        children: [
          nameTag(context),
          pickColor(context),
          getTagSwitch(context),
        ],
      );
    }
    return Column(
      children: [
        const Text('Choose a preexisting tag'),
        Autocomplete<String>(optionsBuilder: (TextEditingValue textEditing) {
          return const Iterable<String>.empty();
        }, onSelected: (String selection) {
          // TODO make the selection with a provider to choose the tags
        }),
        const SizedBox(
          height: 50,
        ),
        getTagSwitch(context)
      ],
    );
  }

  ElevatedButton pickColor(BuildContext context) {
    return ElevatedButton(
            onPressed: () {
              context.read<BudgetFormData>().awaitColorPicker(showDialog<
                  Color?>(
                  context: context,
                  useRootNavigator: false,
                  builder: buildColorPicker));
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: context.watch<BudgetFormData>().tag.color),
            child: const Text('Pick Color'));
  }

  Widget buildColorPicker(BuildContext context) => ChangeNotifierProvider(
        create: (_) => TagColorPicker(Colors.deepPurple),
        builder: (context, child) => AlertDialog(
          content: MaterialPicker(
            pickerColor: context.read<TagColorPicker>().color,
            onColorChanged: (Color color) {
              context.read<TagColorPicker>().color = color;
            },
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(
                      context.read<TagColorPicker>().color);
                },
                child: const Text('Confirm'))
          ],
        ),
      );

  TextFormField nameTag(BuildContext context) {
    return TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name of the tag',
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            context.read<BudgetFormData>().overTag((Tag t) =>
                Tag(color: t.color, name: value, created: t.created));
            return null;
          },
        );
  }

  Row getTagSwitch(BuildContext context) {
    return Row(
      children: [const Text('Or create another one'), _getTagSwitch(context)],
    );
  }

  Switch _getTagSwitch(BuildContext context) {
    return Switch(
        value: context.read<BudgetFormData>().tag.created,
        onChanged: (bool value) {
          context
              .read<BudgetFormData>()
              .setTag(Tag(color: Colors.deepPurple, name: '', created: value));
        });
  }
}