import 'package:flutter/material.dart';
import 'package:easy_formz/easy_formz.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.form});
  final FormPage form;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late final EasyFormzController controller;

  @override
  void initState() {
    super.initState();

    controller = EasyFormzController(forms: widget.form.formConfigs)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.form.label)),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text('Submit'),
          onPressed: () {
            final isValidated = controller.validate();
            if (isValidated) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Submited Values'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children:
                            controller.formValues.map((entry) {
                              return Text('${entry.label}: ${entry.value}');
                            }).toList(),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: EasyFormz(controller: controller)),
      ),
    );
  }
}
