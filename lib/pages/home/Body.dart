import 'package:chow_down/components/customAppBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chow_down/components/builders/list_items_builder.dart';
import 'package:chow_down/components/errors/show_exception_alert_dialog.dart';
import 'package:chow_down/components/job_list_tile.dart';
import 'package:chow_down/models/firestore/job.dart';
import 'package:chow_down/pages/jobs/job_entries/job_entries_page.dart';
import 'package:chow_down/services/firestore/firestore_db.dart';

class HomePage extends StatelessWidget {
  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<Database>(context, listen: false);
      await database.deleteJob(job);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Delete Operation Failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomLogoAppBar(
      imgUrl: 'assets/images/chow_down.png',
      title: 'Home',
      body: _buildContents(context),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return RefreshIndicator(
      // Will refresh data
      onRefresh: () {},
      child: StreamBuilder<List<Job>>(
        stream: database.jobsStream(),
        builder: (context, snapshot) {
          return ListItemsBuilder<Job>(
              snapshot: snapshot,
              itemBuilder: (context, job) => Dismissible(
                    key: Key('job-${job.id}'),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) => _delete(context, job),
                    direction: DismissDirection.endToStart,
                    child: JobsListTile(
                      job: job,
                      onTap: () => JobEntriesPage.show(context, job),
                    ),
                  ));
        },
      ),
    );
  }
}
