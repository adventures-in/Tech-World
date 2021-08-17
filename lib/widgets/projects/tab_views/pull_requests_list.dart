import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tech_world/actions/git_hub/retrieve_git_hub_pull_requests.dart';
import 'package:tech_world/actions/platform/launch_url.dart';
import 'package:tech_world/extensions/build_context_extensions.dart';
import 'package:tech_world/models/app/app_state.dart';
import 'package:tech_world/models/git_hub/git_hub_pull_request.dart';

class PullRequestsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BuiltList<GitHubPullRequest>>(
      onInit: (store) => store.dispatch(RetrieveGitHubPullRequests()),
      distinct: true,
      converter: (store) => store.state.gitHubPullRequests,
      builder: (context, pullRequests) {
        if (pullRequests.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var pullRequest = pullRequests[index];
            return ListTile(
              title: Text('${pullRequest.title}'),
              subtitle: Text('${pullRequest.repositoryOwner.login} '
                  'PR #${pullRequest.number} '
                  'opened by ${pullRequest.author.login} '
                  '(${pullRequest.state})'),
              onTap: () => context.dispatch(
                LaunchURL(url: pullRequest.url),
              ),
            );
          },
          itemCount: pullRequests.length,
        );
      },
    );
  }
}
