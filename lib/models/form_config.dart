import 'package:easy_formz/easy_formz.dart';

/// Represents the configuration of a form field.
class FormConfig {
  /// The unique identifier of the form field.
  final String id;

  /// The type of the form field (e.g., text, checkbox).
  final String type;

  /// The key associated with the form field. (this is used if you need additional identifier for the form field)
  final String formKey;

  /// The label of the form field.
  final String label;

  /// The properties of the form field.
  final FormProps props;

  /// Indicates whether the form field is hidden.
  final bool isHidden;

  /// The value of the form field.
  dynamic value;

  /// Creates a new instance of [FormConfig].
  FormConfig({
    required this.id,
    required this.type,
    required this.formKey,
    required this.label,
    required this.props,
    this.isHidden = false,
    this.value,
  });

  @override
  String toString() {
    return 'FormConfig(id: $id, type: $type, label: $label, props: $props, value: $value)';
  }
}
