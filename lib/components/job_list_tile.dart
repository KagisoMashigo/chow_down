import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/core/data/models/job.dart';

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
