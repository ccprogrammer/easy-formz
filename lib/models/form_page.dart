import 'package:easy_formz/easy_formz.dart';

/// Represents a page in a form.
class FormPage {
  /// The unique identifier of the form page.
  final String id;

  /// The label of the form page.
  final String label;

  /// The description of the form page.
  final String description;

  /// The list of form configurations on the form page.
  final List<FormConfig> formConfigs;

  /// Creates a new instance of [FormPage].
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
