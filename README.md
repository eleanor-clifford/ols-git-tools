# Overleaf Git Tools

Provides integration with git for syncing overleaf projects with
[overleaf-sync](https://github.com/moritzgloeckl/overleaf-sync).
Add this repo as a submodule, setup overleaf-sync as described in their README,
and then run `./ols-git-tools/setup.sh` from the project directory to alias
the syncing tool to `git sync` for the current project.

Don't get any ideas, I don't like Overleaf at all. This just makes it easier to
collaborate with wysiwig people.

There are a lot of possible edge cases so it's possible I've missed one of
them. Please open an issue if anything isn't working as expected.
