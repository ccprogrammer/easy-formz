import 'package:easy_formz/easy_formz.dart';
class FormDate extends StatelessWidget {
  FormDate({
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
    final String selectedValue = config.value ?? '';

    final String convertedDate =
        selectedValue.isNotEmpty ? convertDate(selectedValue) : '';

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
          GestureDetector(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.tryParse(selectedValue),
                firstDate: DateTime(DateTime.now().year - 1000),
                lastDate: DateTime(DateTime.now().year + 1000),
              );
              if (date != null) {
                onChanged(date.toString());
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              width: MediaQuery.of(context).size.width / 1.6,
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      config.props.isWarned
                          ? theme.warningColor
                          : theme.borderColor,
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.date_range,
                    color: theme.iconColor,
                    size: theme.iconSize,
                  ),
                  const SizedBox(width: 8),
                  selectedValue.isEmpty
                      ? const Text('Select Date')
                      : Text(convertedDate),
                ],
              ),
            ),
          ),
          FormWarningLabel(theme: theme, isWarned: config.props.isWarned),
        ],
      ),
    );
  }
}
