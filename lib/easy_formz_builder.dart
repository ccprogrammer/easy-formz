import 'package:easy_formz/easy_formz.dart';

class EasyFormz extends StatefulWidget {
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

  final EasyFormzController controller;
  final EasyFormzTheme theme;

  final Function(FormConfig config, dynamic value)? onFormValuesChanged;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  customBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  inputBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  textareaBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  dropdownBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  checkboxBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  multicheckboxBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  radioBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  dateBuilder;
  final Function(FormConfig config, Function(dynamic value) onValueChanged)?
  timeBuilder;

  final Function(FormConfig config)? errorBuilder;

  @override
  State<EasyFormz> createState() => _EasyFormzState();
}

class _EasyFormzState extends State<EasyFormz> {
  @override
  void initState() {
    widget.controller.addListener(_istener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_istener);
    super.dispose();
  }

  void _istener() {
    if (mounted) {
      setState(() {});
    }
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

        void onChanged(dynamic value) {
          widget.controller.setValue(config, value);
          widget.onFormValuesChanged?.call(config, value);
        }

        switch (config.type) {
          case 'input':
            if (widget.inputBuilder != null) {
              return widget.inputBuilder!(config, (value) => onChanged(value));
            }
            return FormTextBox(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(value),
            );
          case 'textarea':
            if (widget.textareaBuilder != null) {
              return widget.textareaBuilder!(
                config,
                (value) => onChanged(value),
              );
            }
            return FormTextArea(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(value),
            );
          case 'dropdown':
            if (widget.dropdownBuilder != null) {
              return widget.dropdownBuilder!(
                config,
                (value) => onChanged(value),
              );
            }
            return FormDropdown(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(value),
            );
          case 'checkbox':
            if (widget.checkboxBuilder != null) {
              return widget.checkboxBuilder!(
                config,
                (value) => onChanged(value),
              );
            }
            return FormCheckbox(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(value),
            );
          case 'multicheckbox':
            if (widget.multicheckboxBuilder != null) {
              return widget.multicheckboxBuilder!(
                config,
                (value) => onChanged(value),
              );
            }
            return FormMultiCheckbox(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(value),
            );
          case 'radio':
            if (widget.radioBuilder != null) {
              return widget.radioBuilder!(config, (value) => onChanged(value));
            }
            return FormRadio(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(value),
            );
          case 'date':
            if (widget.dateBuilder != null) {
              return widget.dateBuilder!(config, (value) => onChanged(value));
            }
            return FormDate(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(value),
            );
          case 'time':
            if (widget.timeBuilder != null) {
              return widget.timeBuilder!(config, (value) => onChanged(value));
            }
            return FormTime(
              config: config,
              theme: widget.theme,
              onChanged: (value) => onChanged(value),
            );
        }
        return widget.customBuilder?.call(
              config,
              (value) => onChanged(value),
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
