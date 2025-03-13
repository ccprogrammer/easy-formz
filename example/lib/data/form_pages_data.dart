import 'dart:math';
import 'package:easy_formz/models/form_config.dart';
import 'package:easy_formz/models/form_option.dart';
import 'package:easy_formz/models/form_page.dart';
import 'package:easy_formz/models/form_props.dart';

final formPages = _generateRandomFormPages(Random().nextInt(3));

List<FormPage> _generateRandomFormPages(int numberOfPages) {
  final random = Random();
  final formPages = List<FormPage>.generate(numberOfPages, (pageIndex) {
    final formConfigs = List<FormConfig>.generate(8, (configIndex) {
      final id = random.nextInt(1000).toString();
      final types = [
        'input',
        'radio',
        'checkbox',
        'textarea',
        'multicheckbox',
        'date',
        'time',
      ];

      final type = types[random.nextInt(types.length)];
      final formKey = 'dynamic_${type}_key_$configIndex';
      final label = '${type[0].toUpperCase() + type.substring(1)} $configIndex';
      final isRequired = random.nextBool();
      final options =
          type == 'radio' || type == 'checkbox' || type == 'multicheckbox'
              ? List<FormOption>.generate(3, (optionIndex) {
                final optionValue = String.fromCharCode(65 + optionIndex);
                return FormOption(
                  label: 'Option $optionValue',
                  value: optionValue,
                );
              })
              : null;

      return FormConfig(
        id: id,
        type: type,
        formKey: formKey,
        label: label,
        props: FormProps(isRequired: isRequired, options: options),
      );
    });

    return FormPage(
      id: 'page_$pageIndex',
      label: 'Random Page ${pageIndex + 1}',
      description: 'This page displays random forms.',
      formConfigs: formConfigs,
    );
  });

  return [availableForms, ...formPages];
}

// Example usage of the form model
final availableForms = FormPage(
  id: 'gweorj29',
  label: 'Example Page',
  description: 'This form displays all the existing forms available',
  formConfigs: [
    FormConfig(
      id: '412',
      type: 'input',
      formKey: 'dynamic_input_key',
      label: 'Test Form Input',
      props: FormProps(isRequired: true),
    ),
    FormConfig(
      id: '432',
      type: 'radio',
      formKey: 'dynamic_radio_key',
      label: 'Test Form Radio',
      props: FormProps(
        isRequired: false,
        options: [
          FormOption(label: 'Option One', value: 'ONE'),
          FormOption(label: 'Option Two', value: 'TWO'),
          FormOption(label: 'Option Three', value: 'Three'),
        ],
      ),
    ),
    FormConfig(
      id: '612',
      type: 'checkbox',
      formKey: 'dynamic_checkbox_key',
      label: 'Test Form Checkbox',
      props: FormProps(
        isRequired: false,
        options: [
          FormOption(label: 'Option One', value: 'ONE'),
          FormOption(label: 'Option Two', value: 'TWO'),
          FormOption(label: 'Option Three', value: 'Three'),
        ],
      ),
    ),
    FormConfig(
      id: '612',
      type: 'textarea',
      formKey: 'dynamic_textarea_key',
      label: 'Test Form Text Area',
      props: FormProps(isRequired: true),
    ),
    FormConfig(
      id: '232',
      type: 'checkbox',
      formKey: 'dynamic_checkboxNoOption_key',
      label: 'Test Form Checkbox No Option',
      props: FormProps(isRequired: true),
    ),
    FormConfig(
      id: '132',
      type: 'multicheckbox',
      formKey: 'dynamic_multiCheckbox_key',
      label: 'Test Form MultiCheckbox',
      props: FormProps(
        isRequired: true,
        options: [
          FormOption(label: 'Option One', value: 'ONE'),
          FormOption(label: 'Option Two', value: 'TWO'),
          FormOption(label: 'Option Three', value: 'Three'),
        ],
      ),
    ),
    FormConfig(
      id: '162',
      type: 'date',
      formKey: 'dynamic_date_key',
      label: 'Test Form Date',
      props: FormProps(isRequired: false),
    ),
    FormConfig(
      id: '164',
      type: 'time',
      formKey: 'dynamic_time_key',
      label: 'Test Form Time',
      props: FormProps(isRequired: true),
    ),
  ],
);
