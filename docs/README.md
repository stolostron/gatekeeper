# Creating a new release branch

## Prerequisites

- Clone the `gatekeeper` repository and have both `stolostron/gatekeeper` and `open-policy-agent/gatekeeper` as remotes

## Steps

1. Set the target `open-policy-agent` X.Y.Z version and previous `stolostron` release X.Y version:
   ```shell
   NEW_RELEASE_VERSION=X.Y.Z
   PREV_RELEASE=X.Y
   ```
2. Generate the tag, new release, and local remote names:
   ```shell
   TAG=v${NEW_RELEASE_VERSION}
   NEW_RELEASE=${NEW_RELEASE_TAG%.*}
   UPSTREAM="$(git remote -v | grep push | awk '/open-policy-agent/ {print $1}')"
   STOLOSTRON="$(git remote -v | grep push | awk '/stolostron/ {print $1}')"
   ```
3. Fetch the upstream release branch and push to `stolostron`:
   ```shell
   git tag --delete ${TAG}
   git fetch --tags ${UPSTREAM} ${TAG}
   git branch -d release-${NEW_RELEASE}
   git checkout -b release-${NEW_RELEASE} ${TAG}
   git push ${STOLOSTRON} release-${NEW_RELEASE}
   ```
4. After the push, check the [Actions](https://github.com/stolostron/gatekeeper/actions) tab of the repository to see
   whether there are new workflows that might need to be disabled (for example, if it requires a token that is not
   accessible in this repository).
5. Fetch the previous release branch from `stolostron/gatekeeper`, create a new patch branch, and rebase on the new
   release branch, accepting conflicts from the upstream changes:
   ```shell
   git fetch ${STOLOSTRON} release-${PREV_RELEASE}
   git checkout ${STOLOSTRON}/release-${PREV_RELEASE}
   git checkout -b patch-release-${NEW_RELEASE}
   git rebase -X ours ${TAG}
   ```
6. There now should be one or more commits on top from customizations in `stolostron`. Review the changes and squash the
   commits into a single commit, removing irrelevant commits and updating the resulting description if necessary:
   ```shell
   git rebase -i ${TAG}
   ```
7. Push the patch branch to a development fork and open a PR against the new release branch (set `FORK` manually if you
   have more than one development fork):
   ```shell
   FORK="$(git remote -v | grep push | awk '!/(stolostron|open-policy-agent)/ {print $1}')"
   git push -u ${FORK} patch-release-${NEW_RELEASE}
   ```
8. Once the PR is approved and merged: fetch the latest commits, clean the local tag, and tag and push the new release
   in `stolostron/gatekeeper`:
   ```shell
   git fetch ${STOLOSTRON} release-${NEW_RELEASE}
   git checkout ${STOLOSTRON}/release-${NEW_RELEASE}
   git tag --delete ${TAG}
   git tag -a ${TAG} -m ${TAG}
   git push ${STOLOSTRON} ${TAG}
   ```
