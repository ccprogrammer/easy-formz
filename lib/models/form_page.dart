import 'package:easy_formz/models/form_config.dart';

class FormPage {
  final String id;
  final String label;
  final String description;
  final List<FormConfig> formConfigs;

  FormPage({
    required this.id,
    required this.label,
    required this.description,
    required this.formConfigs,
  });

  @override
  String toString() {
    return 'FormPage(id: $id, label: $label, description: $description, formConfigs: $formConfigs)';
  }
}
