import 'package:easy_formz/easy_formz.dart';


class FormProps {
  final bool? isRequired;
  bool isWarned;
  final List<FormOption>? options;

  FormProps({required this.isRequired, this.isWarned = false, this.options});

  @override
  String toString() {
    return 'FormProps(isRequired: $isRequired, isWarned: $isWarned, options: $options)';
  }
}
