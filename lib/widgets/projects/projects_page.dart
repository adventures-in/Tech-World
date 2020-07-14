import 'package:adventures_in_tech_world/enums/projects/projects_tab_selection.dart';
import 'package:adventures_in_tech_world/utils/icons/octo_icons_icons.dart';
import 'package:adventures_in_tech_world/widgets/projects/tab_views/assigned_issues_list.dart';
import 'package:adventures_in_tech_world/widgets/projects/tab_views/pull_requests_list.dart';
import 'package:adventures_in_tech_world/widgets/projects/tab_views/repositories_list.dart';
import 'package:flutter/material.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ProjectsTabSelection.values.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            isScrollable: true,
            tabs: [
              Tab(text: 'Repositories', icon: Icon(OctoIcons.repo)),
              Tab(text: 'Issues', icon: Icon(OctoIcons.issue_opened)),
              Tab(
                  text: 'Pull Requests',
                  icon: Icon(OctoIcons.git_pull_request)),
            ],
          ),
          TabBarView(
            children: [
              RepositoriesList(),
              AssignedIssuesList(),
              PullRequestsList()
            ],
          ),
        ],
      ),
    );
  }
}
