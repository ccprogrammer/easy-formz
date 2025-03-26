import 'package:easy_formz/easy_formz.dart';

/// A widget that displays a group of radio buttons based on the provided configuration.
class FormRadio extends StatelessWidget {
  /// Creates a [FormRadio] widget.
  ///
  /// The [config] and [onChanged] parameters must not be null.
  /// The [theme] parameter is optional and defaults to [EasyFormzTheme] if not provided.
  FormRadio({
    super.key,
    required this.config,
    required this.onChanged,
    EasyFormzTheme? theme,
  }) : theme = theme ?? EasyFormzTheme();

  /// The configuration for the form radio buttons.
  final FormConfig config;

  /// The theme to be used for styling the radio buttons.
  final EasyFormzTheme theme;

  /// Callback function to be called when the value of a radio button changes.
  final Function(dynamic value) onChanged;

  @override
  Widget build(BuildContext context) {
    String selectedValue = config.value ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Displays the label for the radio button group.
          FormLabel(
            label: config.label,
            theme: theme,
            isRequired: config.props.isRequired,
          ),
          Column(
            children: config.props.options!
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: Radio(
                            value: e.value,
                            groupValue: selectedValue,
                            fillColor: WidgetStateColor.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return theme.valueColor;
                              } else {
                                return theme.borderColor;
                              }
                            }),
                            onChanged: (value) {
                              onChanged(e.value);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            onChanged(e.value);
                          },
                          child: Text(
                            e.label,
                            style: theme.optionTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          /// Displays a warning label if there is a warning.
          FormWarningLabel(
            theme: theme,
            isWarned: config.props.isWarned,
          ),
        ],
      ),
    );
  }
}
