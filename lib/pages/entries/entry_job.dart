// 🌎 Project imports:
import 'package:chow_down/models/firestore/entry.dart';
import 'package:chow_down/models/firestore/job.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
