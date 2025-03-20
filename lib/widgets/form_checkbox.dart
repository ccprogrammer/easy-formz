import 'package:easy_formz/easy_formz.dart';

class FormCheckbox extends StatelessWidget {
  FormCheckbox({
    super.key,
    required this.config,
    required this.onChanged,
    EasyFormzTheme? theme,
  }) : theme = theme ?? EasyFormzTheme();

  final FormConfig config;
  final EasyFormzTheme theme;
  final Function(dynamic value) onChanged;

  bool get noOptions =>
      config.props.options == null || config.props.options!.isEmpty;

  @override
  Widget build(BuildContext context) {
    // If checkbox form data only have one option
    if (noOptions) {
      bool selectedValue = config.value ?? false;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: Checkbox(
                    value: selectedValue,
                    activeColor: theme.valueColor,
                    side: WidgetStateBorderSide.resolveWith(
                      (states) =>
                          BorderSide(width: 1.0, color: theme.borderColor),
                    ),
                    onChanged: (value) {
                      onChanged(!selectedValue);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    onChanged(!selectedValue);
                  },
                  child: Text(config.label, style: theme.optionTextStyle),
                ),
                if (config.props.isRequired ?? false)
                  Text(
                    '*',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: theme.warningColor,
                    ),
                  ),
              ],
            ),
            FormWarningLabel(isWarned: config.props.isWarned, theme: theme),
          ],
        ),
      );
    }

    String selectedValue = config.value ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormLabel(
            label: config.label,
            theme: theme,
            isRequired: config.props.isRequired,
          ),
          Column(
            children:
                config.props.options!
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Checkbox(
                                value: e.value == selectedValue,
                                activeColor: theme.valueColor,
                                side: WidgetStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                    width: theme.borderWidth,
                                    color: theme.borderColor,
                                  ),
                                ),
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
          FormWarningLabel(theme: theme, isWarned: config.props.isWarned),
        ],
      ),
    );
  }
}
