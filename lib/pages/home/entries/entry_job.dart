import 'package:time_tracker_flutter_course/core/data/models/entry.dart';
import 'package:time_tracker_flutter_course/core/data/models/job.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
