import 'package:easy_formz/easy_formz.dart';

/// Controller for managing form configurations and values.
class EasyFormzController extends ChangeNotifier {
  /// List of form configurations.
  final List<FormConfig> forms;

  /// List of form values.
  final List<FormValue> formValues = [];

  /// Constructor for initializing the controller with a list of form configurations.
  EasyFormzController({required this.forms});

  /// Sets the value for a given form configuration.
  /// 
  /// If the form configuration type is 'multicheckbox', it handles adding or removing the value from the list.
  /// Otherwise, it sets the value directly.
  /// 
  /// Notifies listeners after updating the value.
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

  /// Validates all forms and updates their warning status.
  /// 
  /// Returns `true` if all required forms have values, otherwise returns `false`.
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

  /// Retrieves the value for a given form configuration.
  /// 
  /// Returns the form value if it exists, otherwise returns `null`.
  FormValue? getValue(FormConfig config) {
    if (formValues.any((form) => form.id == config.id)) {
      return formValues.firstWhere((form) => form.id == config.id);
    }

    return null;
  }

  /// Disposes the controller by clearing all forms and form values.
  @override
  void dispose() {
    forms.clear();
    formValues.clear();
    super.dispose();
  }
}
