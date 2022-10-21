import 'package:flutter/material.dart';

import '../data.dart';

class VacancyList extends StatefulWidget {
  const VacancyList({super.key, this.onTap});
  final ValueChanged<Vacancy>? onTap;

  @override
  // ignore: no_logic_in_create_state
  VacancyListState createState() => VacancyListState(onTap);
}

class VacancyListState extends State<VacancyList> {
  late Future<List<Vacancy>> futureVacancys;
  final ValueChanged<Vacancy>? onTap;

  VacancyListState(this.onTap);

  @override
  void initState() {
    super.initState();
    futureVacancys = fetchVacancys();
  }

  Future<List<Vacancy>> refreshVacancyState() async {
    futureVacancys = fetchVacancys();
    return futureVacancys;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vacancy>>(
      future: refreshVacancyState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          admissionSystemInstance.setVacancies(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                snapshot.data![index].name!,
              ),
              subtitle: Text(
                ' ' +
                    snapshot.data![index].name! +
                    ' ' +
                    snapshot.data![index].description! +
                    ' ' +
                    // snapshot.data![index].organization_id!.toString() +
                    // ' ' +
                    // snapshot.data![index].avinya_type_id!.toString() +
                    // ' ' +
                    // snapshot.data![index].evaluation_cycle_id!.toString() +
                    // ' ' +
                    snapshot.data![index].head_count!.toString() +
                    ' ' +
                    snapshot.data![index].avinya_type!.name! +
                    snapshot.data![index].evaluation_criteria
                        .map((e) => e.prompt)
                        .toList()
                        .toString() +
                    snapshot.data![index].avinya_type!.toString() +
                    ' ' +
                    // snapshot.data![index].evaluation_criteria.toString() +
                    ' ',
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.of(context)
                            .push<void>(
                              MaterialPageRoute<void>(
                                builder: (context) => EditVacancyPage(
                                    vacancy: snapshot.data![index]),
                              ),
                            )
                            .then((value) => setState(() {}));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await _deleteVacancy(snapshot.data![index]);
                        setState(() {});
                      },
                      icon: const Icon(Icons.delete)),
                ],
              ),
              onTap: onTap != null ? () => onTap!(snapshot.data![index]) : null,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  Future<void> _deleteVacancy(Vacancy vacancy) async {
    try {
      await deleteVacancy(vacancy.id!.toString());
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to delete the Vacancy'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
}

class AddVacancyPage extends StatefulWidget {
  static const String route = '/vacancy/add';
  const AddVacancyPage({super.key});
  @override
  _AddVacancyPageState createState() => _AddVacancyPageState();
}

class _AddVacancyPageState extends State<AddVacancyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _name_Controller;
  late FocusNode _name_FocusNode;
  late TextEditingController _description_Controller;
  late FocusNode _description_FocusNode;
  late TextEditingController _organization_id_Controller;
  late FocusNode _organization_id_FocusNode;
  late TextEditingController _avinya_type_id_Controller;
  late FocusNode _avinya_type_id_FocusNode;
  late TextEditingController _evaluation_cycle_id_Controller;
  late FocusNode _evaluation_cycle_id_FocusNode;
  late TextEditingController _head_count_Controller;
  late FocusNode _head_count_FocusNode;
  late TextEditingController _avinya_type_Controller;
  late FocusNode _avinya_type_FocusNode;
  late TextEditingController _evaluation_criteria_Controller;
  late FocusNode _evaluation_criteria_FocusNode;

  @override
  void initState() {
    super.initState();
    _name_Controller = TextEditingController();
    _name_FocusNode = FocusNode();
    _description_Controller = TextEditingController();
    _description_FocusNode = FocusNode();
    _organization_id_Controller = TextEditingController();
    _organization_id_FocusNode = FocusNode();
    _avinya_type_id_Controller = TextEditingController();
    _avinya_type_id_FocusNode = FocusNode();
    _evaluation_cycle_id_Controller = TextEditingController();
    _evaluation_cycle_id_FocusNode = FocusNode();
    _head_count_Controller = TextEditingController();
    _head_count_FocusNode = FocusNode();
    _avinya_type_Controller = TextEditingController();
    _avinya_type_FocusNode = FocusNode();
    _evaluation_criteria_Controller = TextEditingController();
    _evaluation_criteria_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _name_Controller.dispose();
    _name_FocusNode.dispose();
    _description_Controller.dispose();
    _description_FocusNode.dispose();
    _organization_id_Controller.dispose();
    _organization_id_FocusNode.dispose();
    _avinya_type_id_Controller.dispose();
    _avinya_type_id_FocusNode.dispose();
    _evaluation_cycle_id_Controller.dispose();
    _evaluation_cycle_id_FocusNode.dispose();
    _head_count_Controller.dispose();
    _head_count_FocusNode.dispose();
    _avinya_type_Controller.dispose();
    _avinya_type_FocusNode.dispose();
    _evaluation_criteria_Controller.dispose();
    _evaluation_criteria_FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vacancy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text('Fill in the details of the Vacancy you want to add'),
              TextFormField(
                controller: _name_Controller,
                decoration: const InputDecoration(labelText: 'name'),
                onFieldSubmitted: (_) {
                  _name_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _description_Controller,
                decoration: const InputDecoration(labelText: 'description'),
                onFieldSubmitted: (_) {
                  _description_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _organization_id_Controller,
                decoration: const InputDecoration(labelText: 'organization_id'),
                onFieldSubmitted: (_) {
                  _organization_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _avinya_type_id_Controller,
                decoration: const InputDecoration(labelText: 'avinya_type_id'),
                onFieldSubmitted: (_) {
                  _avinya_type_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _evaluation_cycle_id_Controller,
                decoration:
                    const InputDecoration(labelText: 'evaluation_cycle_id'),
                onFieldSubmitted: (_) {
                  _evaluation_cycle_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _head_count_Controller,
                decoration: const InputDecoration(labelText: 'head_count'),
                onFieldSubmitted: (_) {
                  _head_count_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _avinya_type_Controller,
                decoration: const InputDecoration(labelText: 'avinya_type'),
                onFieldSubmitted: (_) {
                  _avinya_type_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _evaluation_criteria_Controller,
                decoration:
                    const InputDecoration(labelText: 'evaluation_criteria'),
                onFieldSubmitted: (_) {
                  _evaluation_criteria_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _addVacancy(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _addVacancy(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final Vacancy vacancy = Vacancy(
          name: _name_Controller.text,
          description: _description_Controller.text,
          organization_id: int.parse(_organization_id_Controller.text),
          avinya_type_id: int.parse(_avinya_type_id_Controller.text),
          evaluation_cycle_id: int.parse(_evaluation_cycle_id_Controller.text),
          head_count: int.parse(_head_count_Controller.text),
          //avinya_type: _avinya_type_Controller.text,
          //evaluation_criteria: _evaluation_criteria_Controller.text,
        );
        await createVacancy(vacancy);
        Navigator.of(context).pop(true);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to add Vacancy'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
}

class EditVacancyPage extends StatefulWidget {
  static const String route = 'vacancy/edit';
  final Vacancy vacancy;
  const EditVacancyPage({super.key, required this.vacancy});
  @override
  _EditVacancyPageState createState() => _EditVacancyPageState();
}

class _EditVacancyPageState extends State<EditVacancyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _name_Controller;
  late FocusNode _name_FocusNode;
  late TextEditingController _description_Controller;
  late FocusNode _description_FocusNode;
  late TextEditingController _organization_id_Controller;
  late FocusNode _organization_id_FocusNode;
  late TextEditingController _avinya_type_id_Controller;
  late FocusNode _avinya_type_id_FocusNode;
  late TextEditingController _evaluation_cycle_id_Controller;
  late FocusNode _evaluation_cycle_id_FocusNode;
  late TextEditingController _head_count_Controller;
  late FocusNode _head_count_FocusNode;
  late TextEditingController _avinya_type_Controller;
  late FocusNode _avinya_type_FocusNode;
  late TextEditingController _evaluation_criteria_Controller;
  late FocusNode _evaluation_criteria_FocusNode;
  @override
  void initState() {
    super.initState();
    final Vacancy vacancy = widget.vacancy;
    _name_Controller = TextEditingController(text: vacancy.name);
    _name_FocusNode = FocusNode();
    _description_Controller = TextEditingController(text: vacancy.description);
    _description_FocusNode = FocusNode();
    _organization_id_Controller =
        TextEditingController(text: vacancy.organization_id.toString());
    _organization_id_FocusNode = FocusNode();
    _avinya_type_id_Controller =
        TextEditingController(text: vacancy.avinya_type_id.toString());
    _avinya_type_id_FocusNode = FocusNode();
    _evaluation_cycle_id_Controller =
        TextEditingController(text: vacancy.evaluation_cycle_id.toString());
    _evaluation_cycle_id_FocusNode = FocusNode();
    _head_count_Controller =
        TextEditingController(text: vacancy.head_count.toString());
    _head_count_FocusNode = FocusNode();
    _avinya_type_Controller =
        TextEditingController(text: vacancy.avinya_type.toString());
    _avinya_type_FocusNode = FocusNode();
    _evaluation_criteria_Controller =
        TextEditingController(text: vacancy.evaluation_criteria.toString());
    _evaluation_criteria_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _name_Controller.dispose();
    _name_FocusNode.dispose();
    _description_Controller.dispose();
    _description_FocusNode.dispose();
    _organization_id_Controller.dispose();
    _organization_id_FocusNode.dispose();
    _avinya_type_id_Controller.dispose();
    _avinya_type_id_FocusNode.dispose();
    _evaluation_cycle_id_Controller.dispose();
    _evaluation_cycle_id_FocusNode.dispose();
    _head_count_Controller.dispose();
    _head_count_FocusNode.dispose();
    _avinya_type_Controller.dispose();
    _avinya_type_FocusNode.dispose();
    _evaluation_criteria_Controller.dispose();
    _evaluation_criteria_FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vacancy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text('Fill in the details of the Vacancy you want to edit'),
              TextFormField(
                controller: _name_Controller,
                decoration: const InputDecoration(labelText: 'name'),
                onFieldSubmitted: (_) {
                  _name_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _description_Controller,
                decoration: const InputDecoration(labelText: 'description'),
                onFieldSubmitted: (_) {
                  _description_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _organization_id_Controller,
                decoration: const InputDecoration(labelText: 'organization_id'),
                onFieldSubmitted: (_) {
                  _organization_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _avinya_type_id_Controller,
                decoration: const InputDecoration(labelText: 'avinya_type_id'),
                onFieldSubmitted: (_) {
                  _avinya_type_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _evaluation_cycle_id_Controller,
                decoration:
                    const InputDecoration(labelText: 'evaluation_cycle_id'),
                onFieldSubmitted: (_) {
                  _evaluation_cycle_id_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _head_count_Controller,
                decoration: const InputDecoration(labelText: 'head_count'),
                onFieldSubmitted: (_) {
                  _head_count_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _avinya_type_Controller,
                decoration: const InputDecoration(labelText: 'avinya_type'),
                onFieldSubmitted: (_) {
                  _avinya_type_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _evaluation_criteria_Controller,
                decoration:
                    const InputDecoration(labelText: 'evaluation_criteria'),
                onFieldSubmitted: (_) {
                  _evaluation_criteria_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _editVacancy(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  Future<void> _editVacancy(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        final Vacancy vacancy = Vacancy(
          id: widget.vacancy.id,
          name: _name_Controller.text,
          description: _description_Controller.text,
          organization_id: int.parse(_organization_id_Controller.text),
          avinya_type_id: int.parse(_avinya_type_id_Controller.text),
          evaluation_cycle_id: int.parse(_evaluation_cycle_id_Controller.text),
          head_count: int.parse(_head_count_Controller.text),
          // avinya_type: _avinya_type_Controller.text,
          // evaluation_criteria: _evaluation_criteria_Controller.text,
        );
        await updateVacancy(vacancy);
        Navigator.of(context).pop(true);
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to edit the Vacancy'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
}
