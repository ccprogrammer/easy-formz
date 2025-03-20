import 'package:easy_formz/easy_formz.dart';

class FormConfig {
  final String id;
  final String type;
  final String formKey;
  final String label;
  final FormProps props;
  final bool isHidden;
  dynamic value;

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
