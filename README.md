# git-config-toggle
Allows you to quickly toggle between git user configs, which is useful for when you have multiple signing keys

## Usage:
Add the following somewhere in your `.bashrc` or `.zshrc` file:
```
export GPG_TTY=$(tty)
```

Add the `git-config-toggle.sh` to your `$PATH`, `chmod u+x` the script file if necessary, and then within a local Git repo launch the script from terminal like so:

```
./git-config-toggle.sh
```
