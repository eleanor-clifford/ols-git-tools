# Overleaf Git Tools

Provides integration with git for syncing overleaf projects with
[overleaf-sync](https://github.com/moritzgloeckl/overleaf-sync).

Don't get any ideas, I don't like Overleaf at all. This just makes it easier to
collaborate with wysiwig people.

There are a lot of possible edge cases so it's possible I've missed one of
them. Please open an issue if anything isn't working as expected.

To set up the integration, first install
[overleaf-sync](https://github.com/moritzgloeckl/overleaf-sync) and log in with
```
ols login [-u/--username -p/--pasword --path]
```
note that ols requires that the name of your folder is the same as the name of
the project on overleaf.

Then add this repo as a submodule and setup the git tools by running the
following from any Linux/MacOS terminal, or Git Bash on Windows
```
git submodule update --init
./ols-git-tools/setup.sh
```

You can now use `git sync` to merge the overleaf changes into git. Note that
the automatic merge may not achieve your goals (it forces a conflict) but you
can manually compare the changes with `git diff HEAD~`

Also note (from the
[overleaf-sync](https://github.com/moritzgloeckl/overleaf-sync) docs):

> When modifying a file on Overleaf and immediately syncing afterwards, the
> tool might not detect the changes. Please allow 1-2 minutes after modifying a
> file on Overleaf before syncing it to your local computer.
