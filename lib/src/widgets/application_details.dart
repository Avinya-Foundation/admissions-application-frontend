import 'package:flutter/material.dart';

import '../data.dart';

class ApplicationDetails extends StatefulWidget {
  const ApplicationDetails({super.key, this.onTap});
  final ValueChanged<Application>? onTap;

  @override
  // ignore: no_logic_in_create_state
  ApplicationDetailsState createState() => ApplicationDetailsState(onTap);
}

class ApplicationDetailsState extends State<ApplicationDetails> {
  late Future<Application> futureApplication;
  final ValueChanged<Application>? onTap;

  ApplicationDetailsState(this.onTap);

  @override
  void initState() {
    super.initState();
    futureApplication =
        fetchApplication(admissionSystemInstance.getStudentPerson().id!);
  }

  Future<Application> refreshApplicationState() async {
    futureApplication =
        fetchApplication(admissionSystemInstance.getStudentPerson().id!);
    return futureApplication;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Application>(
      future: refreshApplicationState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          admissionSystemInstance.setApplication(snapshot.data);
          return ListView.builder(
            itemCount: snapshot.data!.statuses.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                'Application submitted on ' + snapshot.data!.application_date!,
              ),
              subtitle: Text(
                ' ' +
                    snapshot.data!.statuses[index].status! +
                    ' ' +
                    snapshot.data!.statuses[index].updated! +
                    ' ',
              ),
              onTap: onTap != null ? () => onTap!(snapshot.data!) : null,
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
}
