// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:chow_down/models/firestore/job.dart';

class JobsListTile extends StatelessWidget {
  const JobsListTile({Key key, @required this.job, this.onTap})
      : super(key: key);

  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right_outlined),
    );
  }
}
