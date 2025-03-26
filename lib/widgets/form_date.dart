import 'package:easy_formz/easy_formz.dart';

/// A widget that displays a date picker form field.
class FormDate extends StatelessWidget {
  /// Creates a [FormDate] widget.
  ///
  /// The [config] and [onChanged] parameters must not be null.
  /// The [theme] parameter is optional and defaults to [EasyFormzTheme].
  FormDate({
    super.key,
    required this.config,
    required this.onChanged,
    EasyFormzTheme? theme,
  }) : theme = theme ?? EasyFormzTheme();

  /// The configuration for the form field.
  final FormConfig config;

  /// The theme for the form field.
  final EasyFormzTheme theme;

  /// The callback that is called when the date is changed.
  final Function(dynamic value) onChanged;

  @override
  Widget build(BuildContext context) {
    final String selectedValue = config.value ?? '';

    final String convertedDate =
        selectedValue.isNotEmpty ? _convertDate(selectedValue) : '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Displays the label for the form field.
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

String _convertDate(String selectedValue) {
  if (selectedValue.isNotEmpty) {
    final DateTime dateTime = DateTime.parse(selectedValue);
    final String month =
        (() {
          switch (dateTime.month) {
            case 1:
              return 'January';
            case 2:
              return 'February';
            case 3:
              return 'March';
            case 4:
              return 'April';
            case 5:
              return 'May';
            case 6:
              return 'June';
            case 7:
              return 'July';
            case 8:
              return 'August';
            case 9:
              return 'September';
            case 10:
              return 'October';
            case 11:
              return 'November';
            case 12:
              return 'December';
            default:
              return '';
          }
        })();
    final String formattedDate = '$month ${dateTime.day}, ${dateTime.year}';
    return formattedDate;
  } else {
    return '';
  }
}
