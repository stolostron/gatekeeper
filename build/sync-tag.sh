#! /bin/bash

set -e

# Check for sed/gsed
if [[ "$(uname -s | tr '[:upper:]' '[:lower:]')" == "darwin" ]]; then
  if ! command -v gsed >/dev/null; then
    error "gsed not found. Install with: brew install gnu-sed"
  fi
  SED="gsed"
else
  SED="sed"
fi

# Accept optional positional argument for new_tag, or fetch latest release from upstream
if [ -n "$1" ]; then
  new_tag="$1"
  echo "* Using provided tag: ${new_tag}"
else
  echo "* No tag provided, fetching latest release from upstream open-policy-agent/gatekeeper..."
  new_tag=$(curl --fail -s https://api.github.com/repos/open-policy-agent/gatekeeper/releases/latest | jq -r '.tag_name')

  if [ -z "${new_tag}" ]; then
    echo "ERROR: Failed to fetch latest release from upstream"
    exit 1
  fi

  echo "* Latest release detected: ${new_tag}"
fi

upstream="$(git remote -v | awk '/open-policy-agent.*\(push\)$/ {print $1}')"
stolostron="$(git remote -v | awk '/stolostron.*\(push\)$/ {print $1}')"
dev="$(
  git remote -v | grep push | awk '!/(stolostron|open-policy-agent)/ {print $1}'
)"
release_branch="release-$(echo "${new_tag}" | grep -Eo '[0-9]+\.[0-9]+')"
release_branch_path="${stolostron}/${release_branch}"

if [ "$(echo "${dev}" | wc -l)" -ne 1 ]; then
  echo "ERROR: failed to detect a unique repository development fork"
  exit 1
fi

# Fetch the upstream tags -- ignore errors since the forked tags conflict with the upstream tags
git fetch --tags "${upstream}" &>/dev/null || true

printf "\n* Listing commits to be added from %s to %s...\n" "${release_branch_path}" "${new_tag}"
git log --oneline "${release_branch_path}".."${new_tag}"

echo
read -p "Continue with branch creation and cherry-pick? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 0
fi

# Create a branch and cherry-pick the commits
git checkout -b "upstream-sync-${new_tag}" "${release_branch_path}"
git cherry-pick --empty=keep --signoff -X theirs "${release_branch_path}".."${new_tag}"

printf "\n* Applying stolostron customizations...\n"
printf "\n* Updating manager.yaml...\n"
${SED} -i "s%\(image: \)openpolicyagent/gatekeeper:%\1quay.io/gatekeeper/gatekeeper:%" config/manager/manager.yaml
${SED} -i "s%\(imagePullPolicy: \)Always%\1IfNotPresent%g" config/manager/manager.yaml

printf "\n* Regenerating manifests...\n"
make -f Makefile.stolostron manifests 1>/dev/null

printf "\n* Updating Dockerfile.rhtap...\n"
${SED} -i "s%version.Version=v[^\"]\+%version.Version=${new_tag}%" build/Dockerfile.rhtap
${SED} -i "s/^\(LABEL version=\).*/\1${new_tag}/" build/Dockerfile.rhtap

printf "\n* Adding changes and committing...\n"
git add .
git commit -S -s -m "chore: stolostron patches for ${new_tag}"

echo
read -p "Push the branch to the development fork? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 0
fi

git push -u "${dev}/upstream-sync-${new_tag}"

printf "\nOpen a PR with the new commits. Once the PR is approved and merged, run the following commands to tag and push the final release:\n"

# Fetch latest commits from release branch
echo "  git fetch ${stolostron} ${release_branch}"
echo "  git checkout ${release_branch_path}"

# Delete and recreate tag locally
echo "  git tag --delete ${new_tag} 2>/dev/null || true"
echo "  git tag -a ${new_tag} -m ${new_tag}"

# Push tag to stolostron
echo "  git push ${stolostron} ${new_tag}"
