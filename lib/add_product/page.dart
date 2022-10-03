import 'package:example/add_product/steps/general_attributes.dart';
import 'package:example/add_product/steps/submit.dart';
import 'package:example/add_product/steps/tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart';

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

class _BudgetFormWidgetState extends State<BudgetFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BudgetFormData(0, TimeTagEnum.oneTime, '',
            Tag(color: Colors.teal, name: '', created: false)),
        builder: (context, child) {
          var stepsList = getSteps(context);
          return Form(
            key: _formKey,
            child: Stepper(
              currentStep: context.watch<BudgetFormData>().step,
              onStepCancel: () {
                context
                    .read<BudgetFormData>()
                    .overStep((i) => (i > 0) ? i - 1 : i);
              },
              onStepContinue: () {
                context
                    .read<BudgetFormData>()
                    .overStep((i) => (i + 1 < stepsList.length) ? i + 1 : i);
              },
              onStepTapped: (int index) {
                context.read<BudgetFormData>().overStep((_) => index);
              },
              steps: stepsList,
            ),
          );
        });
  }

  List<Step> getSteps(BuildContext context) {
    return <Step>[
      const Step(
        title: Text('General attributes'),
        content: GeneralAttributesStep(),
      ),
      const Step(title: Text('Choose the Tag'), content: TagStep()),
      Step(
          title: const Text('Submit the form!'), content: SubmitStep(_formKey)),
    ];
  }
}
