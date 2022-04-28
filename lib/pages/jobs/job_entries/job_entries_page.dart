// 🎯 Dart imports:
import 'dart:async';

// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// 🌎 Project imports:
import 'package:chow_down/components/builders/list_items_builder.dart';
import 'package:chow_down/components/errors/show_exception_alert_dialog.dart';
import 'package:chow_down/models/firestore/entry.dart';
import 'package:chow_down/models/firestore/job.dart';
import 'package:chow_down/pages/jobs/edit_job_page.dart';
import 'package:chow_down/pages/jobs/job_entries/entry_list_item.dart';
import 'package:chow_down/pages/jobs/job_entries/entry_page.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({@required this.database, @required this.job});
  final Database database;
  final Job job;

  static Future<void> show(BuildContext context, Job job) async {
    final database = Provider.of<Database>(context, listen: false);
    // Root navigator set to true is especially useful when you
    // want the user to not be able to navigate away
    await Navigator.of(context).push(
      CupertinoPageRoute(
        // on iOS it slides the page in from the right with a back button
        fullscreenDialog: false,
        builder: (context) => JobEntriesPage(database: database, job: job),
      ),
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2.0,
        title: Text(job.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () => EditJobPage.show(
              context,
              job: job,
              database: database,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () => EntryPage.show(
              context: context,
              database: database,
              job: job,
            ),
          ),
        ],
      ),
      body: _buildContent(context, job),
    );
  }

  Widget _buildContent(BuildContext context, Job job) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(job: job),
      builder: (context, snapshot) {
        return ListItemsBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry.id}'),
              entry: entry,
              job: job,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context: context,
                database: database,
                job: job,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}
