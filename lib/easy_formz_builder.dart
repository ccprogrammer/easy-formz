import 'package:easy_formz/easy_formz.dart';

/// A widget that builds a form based on the provided configuration and controller.
class EasyFormz extends StatefulWidget {
  /// Creates an [EasyFormz] widget.
  ///
  /// The [controller] parameter is required.
  /// The [theme] parameter is optional and defaults to [EasyFormzTheme].
  EasyFormz({
    super.key,
    required this.controller,
    EasyFormzTheme? theme,
    this.onFormValuesChanged,
    this.customBuilder,
    this.inputBuilder,
    this.textareaBuilder,
    this.dropdownBuilder,
    this.checkboxBuilder,
    this.multicheckboxBuilder,
    this.radioBuilder,
    this.dateBuilder,
    this.timeBuilder,
    this.errorBuilder,
  }) : theme = theme ?? EasyFormzTheme();

  /// The controller that manages the form state.
  final EasyFormzController controller;

  /// The theme for the form.
  final EasyFormzTheme theme;

  /// Callback when form values change.
  final Function(FormConfig config, dynamic value)? onFormValuesChanged;

  /// Custom builder for form fields.
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  customBuilder;

  /// Builder for input fields.
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  inputBuilder;

  /// Builder for textarea fields.
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  textareaBuilder;

  /// Builder for dropdown fields.
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  dropdownBuilder;

  /// Builder for checkbox fields.
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  checkboxBuilder;

  /// Builder for multicheckbox fields.
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  multicheckboxBuilder;

  /// Builder for radio fields.
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  radioBuilder;

  /// Builder for date fields.
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  dateBuilder;

  /// Builder for time fields.
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  timeBuilder;

  /// Builder for error messages.
  final Function(FormConfig config)? errorBuilder;

  @override
  State<EasyFormz> createState() => _EasyFormzState();
}

class _EasyFormzState extends State<EasyFormz> {
  @override
  void initState() {
    widget.controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  /// Listener for form value changes.
  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }

  /// Handles form value changes.
  ///
  /// Updates the controller and calls the [onFormValuesChanged] callback.
  void onChanged(FormConfig config, dynamic value) {
    widget.controller.setValue(config, value);
    widget.onFormValuesChanged?.call(config, value);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.controller.forms.length,
      itemBuilder: (context, index) {
        final FormConfig config = widget.controller.forms[index];

        if (config.isHidden) return const SizedBox.shrink();

        switch (config.type) {
          case 'input':
            if (widget.inputBuilder != null) {
              return widget.inputBuilder!(
                config,
                (value) => onChanged(config, value),
              );
            }
            return FormTextBox(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(config, value),
            );
          case 'textarea':
            if (widget.textareaBuilder != null) {
              return widget.textareaBuilder!(
                config,
                (value) => onChanged(config, value),
              );
            }
            return FormTextArea(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(config, value),
            );
          case 'dropdown':
            if (widget.dropdownBuilder != null) {
              return widget.dropdownBuilder!(
                config,
                (value) => onChanged(config, value),
              );
            }
            return FormDropdown(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(config, value),
            );
          case 'checkbox':
            if (widget.checkboxBuilder != null) {
              return widget.checkboxBuilder!(
                config,
                (value) => onChanged(config, value),
              );
            }
            return FormCheckbox(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(config, value),
            );
          case 'multicheckbox':
            if (widget.multicheckboxBuilder != null) {
              return widget.multicheckboxBuilder!(
                config,
                (value) => onChanged(config, value),
              );
            }
            return FormMultiCheckbox(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(config, value),
            );
          case 'radio':
            if (widget.radioBuilder != null) {
              return widget.radioBuilder!(
                config,
                (value) => onChanged(config, value),
              );
            }
            return FormRadio(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(config, value),
            );
          case 'date':
            if (widget.dateBuilder != null) {
              return widget.dateBuilder!(
                config,
                (value) => onChanged(config, value),
              );
            }
            return FormDate(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(config, value),
            );
          case 'time':
            if (widget.timeBuilder != null) {
              return widget.timeBuilder!(
                config,
                (value) => onChanged(config, value),
              );
            }
            return FormTime(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(config, value),
            );
        }
        return widget.customBuilder?.call(
              config,
              (value) => onChanged(config, value),
            ) ??
            widget.errorBuilder?.call(config) ??
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Failed to render form.'),
            );
      },
    );
  }
}
