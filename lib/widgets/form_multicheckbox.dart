import 'package:easy_formz/easy_formz.dart';

class FormMultiCheckbox extends StatelessWidget {
  FormMultiCheckbox({
    super.key,
    required this.config,
    required this.onChanged,
    EasyFormzTheme? theme,
  }) : theme = theme ?? EasyFormzTheme();

  final FormConfig config;
  final EasyFormzTheme theme;
  final Function(dynamic value) onChanged;

  @override
  Widget build(BuildContext context) {
    final List<String> selectedValue = config.value ?? [];

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
                                value: selectedValue.any(
                                  (element) => element == e.value,
                                ),
                                side: WidgetStateBorderSide.resolveWith(
                                  (states) => BorderSide(
                                    width: 1.0,
                                    color: theme.borderColor,
                                  ),
                                ),
                                activeColor: theme.valueColor,
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
