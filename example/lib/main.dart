import 'package:easy_formz/easy_formz.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Formz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy Formz')),
      body: ListView.separated(
        itemCount: formPages.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemBuilder: (context, index) {
          final form = formPages[index];

          return _buildCard(form);
        },
      ),
    );
  }

  _buildCard(FormPage form) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    clipBehavior: Clip.antiAlias,
    child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormScreen(form: form)),
        );
      },
      title: Text(form.label, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        form.description,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    ),
  );
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.form});
  final FormPage form;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  late final EasyFormzController controller = EasyFormzController(
    forms: widget.form.formConfigs,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.form.label)),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text('Submit'),
          onPressed: () {
            final isValidated = controller.validate();
            if (isValidated) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Submited Values'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children:
                            controller.formValues.map((entry) {
                              return Text('${entry.label}: ${entry.value}');
                            }).toList(),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: EasyFormz(controller: controller)),
      ),
    );
  }
}

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
