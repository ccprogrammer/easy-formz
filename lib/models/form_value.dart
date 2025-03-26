/// Represents the value of a form field.
class FormValue {
  /// The unique identifier of the form value.
  final String id;

  /// The key associated with the form field.
  final String formKey;

  /// The label of the form field.
  final String label;

  /// The value of the form field.
  final dynamic value;

  /// Creates a new instance of [FormValue].
  FormValue({
    required this.id,
    required this.formKey,
    required this.label,
    required this.value,
  });

  @override
  String toString() {
    return 'FormValue(id: $id, formKey: $formKey, label: $label, value: $value)';
  }
}
