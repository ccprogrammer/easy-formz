import 'package:easy_formz/models/form_page.dart';
import 'package:example/data/form_pages_data.dart';
import 'package:example/screens/form_screen.dart';
import 'package:flutter/material.dart';

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
