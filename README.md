### EasyFormz Package

The purpose of this package is to facilitate the creation of dynamic forms based on data received from the server. The package provides several basic components, including form types such as 'input', 'textarea', 'dropdown', 'checkbox', 'multicheckbox', 'radio', 'date', and 'time'. Additionally, users have the flexibility to create custom forms if none of the predefined form types suit their needs.

<img src="https://github.com/ccprogrammer/easy-formz/raw/main/lib/assets/easy-formz-video.gif?raw=true" alt="The example app running in iOS"  width="100%" />

## Available Form Types

1. **Input**: Single-line text input.
2. **Textarea**: Multi-line text input.
3. **Dropdown**: Dropdown selection.
4. **Checkbox**: Single checkbox.
5. **Multicheckbox**: Multiple checkboxes.
6. **Radio**: Radio button selection.
7. **Date**: Date picker for selecting a date.
8. **Time**: Time picker for selecting a time.

## Using the EasyFormz Widget

To integrate the package into your Flutter application, follow these steps:

1. Add the `EasyFormz` widget to your widget tree:

   ```dart
   EasyFormz(controller: controller)
   ```

2. Initialize the form controller with the desired form data & Keep your UI in sync by listening to changes on the form controller. Example:

   ```dart
    late final EasyFormzController controller = EasyFormzController(forms: widget.form.formConfigs);

    @override
    Widget build(BuildContext context) {
      return Scaffold();
    }
   ```

   The forms data should be look like this

   ```dart
   final forms = [
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
          FormOption(label: 'Option Three', value: 'THREE'),
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
          FormOption(label: 'Option Three', value: 'THREE'),
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
          FormOption(label: 'Option Three', value: 'THREE'),
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
   ];
   ```

3. Let's say you have a list of form page then you can do like the following example:

   ```dart
   final formPages = [
       FormPage(
            id: 'gweorj29',
            label: 'Example Page 1',
            description: 'This form displays all the existing forms available',
            formConfigs: forms1,
        ),
           FormPage(
            id: 'gweorj29',
            label: 'Example Page 2',
            description: 'This form displays all the existing forms available',
            formConfigs: forms2,
        ),
   ];
   ```

   To diplay all the form pages as a ListTile

   ```dart
   ListView.separated(
        itemCount: formPages.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemBuilder: (context, index) {
          final form = formPages[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormScreen(form: form),
                  ),
                );
              },
              title: Text(
                form.label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                form.description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        },
      ),
   ```

   Inside the FormScreen get the form parameter like the following example:

   ```dart
    late final EasyFormzController controller;

    @override
    void initState() {
    super.initState();

        controller = EasyFormzController(forms: widget.form.formConfigs)
        ..addListener(() {
            setState(() {});
        });

    }
   ```

## Custom Form Creation

In scenarios where the provided form types do not meet specific requirements, users can easily create custom forms tailored to their needs.

### Basic Component Builder

To change any in-built form component such as `inputBuilder`, etc, consider the following example:

```dart
EasyFormz(
controller: controller,
inputBuilder: (config, onValueChanged) => Padding(
 padding: const EdgeInsets.all(16),
 child: TextFormField(
   onChanged: (value) {
     onValueChanged(value);
   },
 ),
),
);
```

### Custom Form Component Builder

To create a custom form component based on the form configuration using the `customBuilder`, consider the following example:

```dart
EasyFormz(
  controller: controller,
  customBuilder: (config, onValueChanged) {
    if (config.type == 'custom_form') {
      // Customize and return the specific custom form component based on the condition.
      return CustomDropdown(
        config: config,
        onChanged: (value) => onValueChanged(value),
      );
    }
  },
);
```

### Custom Error Component Builder

Custom error component is available by using the `errorBuilder`, consider the following example:

```dart
EasyFormz(
  controller: controller,
  errorBuilder: (config) {
    return CustomErrorBox(
        label: '${config.label} cannot be rendered',
      );
  },
);
```

### Customizing the Dynamic Form Theme

To personalize the appearance of the dynamic form, you can modify the theme settings using the `theme` parameter. Below is an example of customizing the theme for a `EasyFormz`:

```dart
EasyFormz(
  controller: controller,
  theme: EasyFormzTheme(
        borderColor: Colors.grey,
        borderWidth: 1.5,
        iconColor: Colors.black45,
        iconSize: 24,
        labelTextStyle: const TextStyle(),
        optionTextStyle: const TextStyle(),
        valueColor: Colors.green,
        warningColor: Colors.red,
        warningTextStyle: const TextStyle(),
    )
)
```
