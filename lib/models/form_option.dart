/// Represents an option in a form field.
class FormOption {
  /// The label of the form option.
  final String label;

  /// The value of the form option.
  final String value;

  /// Creates a new instance of [FormOption].
  FormOption({required this.label, required this.value});

  @override
  String toString() => 'FormOption(label: $label, value: $value)';
}
