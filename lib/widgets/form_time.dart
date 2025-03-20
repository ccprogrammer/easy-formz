import 'package:easy_formz/easy_formz.dart';

class FormTime extends StatelessWidget {
  FormTime({
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

    DateTime? dateTime =
        selectedValue.isNotEmpty ? convertTime(selectedValue) : null;

    TimeOfDay timeOfDay =
        dateTime != null ? TimeOfDay.fromDateTime(dateTime) : TimeOfDay.now();

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
              final time = await showTimePicker(
                context: context,
                initialTime: timeOfDay,
              );
              if (time != null) {
                if (context.mounted) {
                  onChanged(time.format(context));
                }
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
                    Icons.watch_later_outlined,
                    color: theme.iconColor,
                    size: theme.iconSize,
                  ),
                  const SizedBox(width: 8),
                  selectedValue.isEmpty
                      ? const Text('Select Time')
                      : Text(selectedValue),
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
