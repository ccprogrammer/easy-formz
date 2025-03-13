class FormValue {
  final String id;
  final String formKey;
  final String label;
  final dynamic value;

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
