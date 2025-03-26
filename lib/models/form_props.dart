import 'package:easy_formz/easy_formz.dart';

/// Represents the properties of a form field.
class FormProps {
  /// Indicates whether the form field is required.
  final bool? isRequired;

  /// Indicates whether the form field has a warning.
  bool isWarned;

  /// The options available for the form field.
  final List<FormOption>? options;

  /// Creates a new instance of [FormProps].
  FormProps({required this.isRequired, this.isWarned = false, this.options});

  @override
  String toString() {
    return 'FormProps(isRequired: $isRequired, isWarned: $isWarned, options: $options)';
  }
}
