import 'package:easy_formz/easy_formz.dart';
class EasyFormzController extends ChangeNotifier {
  final List<FormConfig> forms;
  final List<FormValue> formValues = [];

  EasyFormzController({required this.forms});

  void setValue(FormConfig config, dynamic value) {
    if (formValues.any((form) => form.id == config.id)) {
      formValues.removeWhere((form) => form.id == config.id);
    }

    if (config.type == 'multicheckbox') {
      config.value ??= <String>[];
      final values = config.value as List<String>;
      if (values.any((existingValue) => existingValue == value)) {
        values.remove(value);
      } else {
        values.add(value);
      }
    } else {
      config.value = value;
    }

    formValues.add(
      FormValue(
        id: config.id,
        formKey: config.formKey,
        label: config.label,
        value: config.value,
      ),
    );

    notifyListeners();
  }

  bool validate() {
    bool isValid = true;
    for (var form in forms) {
      if ((form.props.isRequired ?? false) && form.value == null) {
        form.props.isWarned = true;
      } else {
        if (form.props.isWarned == true) {
          form.props.isWarned = false;
        }
      }
    }

    if (forms.any((form) => form.props.isWarned)) {
      isValid = false;
    } else {
      isValid = true;
    }

    notifyListeners();

    return isValid;
  }

  FormValue? getValue(FormConfig config) {
    if (formValues.any((form) => form.id == config.id)) {
      return formValues.firstWhere((form) => form.id == config.id);
    }

    return null;
  }

  @override
  void dispose() {
    forms.clear();
    formValues.clear();
    super.dispose();
  }
}
