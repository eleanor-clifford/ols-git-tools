#!/bin/sh

# Check that we're not already on the overleaf branch
current_branch="$(git branch --show-current)"
if [ "$current_branch" = "overleaf" ]; then
	echo "You should not be working in the overleaf branch."
	echo "Please switch to a different branch first"
	exit 1
fi

# Check that the working tree is clean
if ! [ "$(git diff HEAD)" = "" ]; then
	echo "Please commit your changes first, it will make merging easier."
	echo "You will be able to squash this commit later with \`git rebase -i\`"
	exit 1
fi

# We want the overleaf branch to be based on the state of this branch, so it's
# easiest to just delete it if it exists. Git will warn the user if there are
# changes on the overleaf branch.
if git branch | grep -q overleaf; then
	echo -n "Please ensure that there are no important commits on the overleaf "
	echo "branch, they will be destroyed."
	read -p "Proceed? (y/n) " yn
	case yn in
		[Yy]* )
			if ! git branch -d overleaf; then
				exit 1
			fi
			;;
		[Nn]* ) exit 1;;
		*)      echo "No response, exiting..."; exit 1;;
	esac
fi

git checkout -b overleaf
# Don't bother with asking the user to confirm because the version control is
# in git. Only sync from remote to local.
yes | ols --remote-only
if [ "$(git diff HEAD)" = "" ]; then
	echo "Already up to date."
	git switch $current_branch >/dev/null
	git branch -d overleaf >/dev/null
else
	# We want to cause a merge conflict if there should be one, the easiest way
	# to do this is to just set the overleaf branch back one commit first
	git reset HEAD~ >/dev/null
	git add .
	git commit -m "Overleaf synced at $(date -u +"%Y-%m-%d %H:%M:%S")"
	git switch $current_branch >/dev/null

	# I want the merge to be one commit if it succeeds, please lmk if there's a
	# better way of doing this
	if git merge overleaf --no-edit; then
		git reset HEAD~ >/dev/null
		git add .
		git commit -m \
			"Overleaf synced at $(date -u +"%Y-%m-%d %H:%M:%S")" >/dev/null
	fi

fi

echo
echo -n "Once you are happy with your changes, use \`ols --local-only\` "
echo    "to sync your changes to overleaf"

