import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductForm {
  final double budget;

  AddProductForm({
    required this.budget,
  });
}

class AddProductPage extends StatelessWidget {
  const AddProductPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
      ),
      body: const Center(child: BudgetFormWidget()),
    );
  }
}

class BudgetFormWidget extends StatefulWidget {
  const BudgetFormWidget({super.key});

  @override
  State<BudgetFormWidget> createState() => _BudgetFormWidgetState();
}

enum TimeTagEnum { daily, weekly, monthly, annualy, oneTime }

class TimeTagTuple {
  final String title;
  final TimeTagEnum timeTag;

  TimeTagTuple({required this.title, required this.timeTag});
}

List<TimeTagTuple> allTags = [
  TimeTagTuple(title: 'One time', timeTag: TimeTagEnum.oneTime),
  TimeTagTuple(title: 'Monthly', timeTag: TimeTagEnum.monthly),
  TimeTagTuple(title: 'Daily', timeTag: TimeTagEnum.daily),
  TimeTagTuple(title: 'Weekly', timeTag: TimeTagEnum.weekly),
  TimeTagTuple(title: 'Annually', timeTag: TimeTagEnum.annualy),
];

class Tag {
  Color color;
  String name;

  Tag({
    required this.color,
    required this.name,
  });
}

class BudgetFormData with ChangeNotifier {
  double _budget;
  TimeTagEnum _timeTag;
  double get budget => _budget;
  String _description;
  Tag _tag;

  BudgetFormData(this._budget, this._timeTag, this._description, this._tag);

  void setBudget(double budget) {
    _budget = budget;
    notifyListeners();
  }

  void setTimeTagEnum(TimeTagEnum timeTagEnum) {
    _timeTag = timeTagEnum;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setTag(Tag tag) {
    _tag = tag;
    notifyListeners();
  }

  TimeTagEnum get timeTag => _timeTag;

  String get description => _description;

  Tag get tag => _tag;
}

class _BudgetFormWidgetState extends State<BudgetFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BudgetFormData(
            0, TimeTagEnum.oneTime, '', Tag(color: Colors.teal, name: '')),
        builder: (context, child) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Budget',
                        hintText: 'Enter your budget',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        context
                            .read<BudgetFormData>()
                            .setBudget(double.parse(value));
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text('Repetition'),
                    Column(
                      children: allTags
                          .map(
                            (e) => ListTile(
                                title: Text(e.title),
                                leading: Radio<TimeTagEnum>(
                                  value: e.timeTag,
                                  groupValue:
                                      context.watch<BudgetFormData>().timeTag,
                                  onChanged: (TimeTagEnum? value) {
                                    if (value != null) {
                                      context
                                          .read<BudgetFormData>()
                                          .setTimeTagEnum(value);
                                    }
                                  },
                                )),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 40,),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        context.read<BudgetFormData>().setDescription(value);
                        return null; // now it does not do anytinh
                      },
                    ),
                    Padding(
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
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
