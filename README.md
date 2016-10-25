# robbernabe-workstation

Resources for setting up workstation and dotfiles

This is a personal fork of the [Chef Pantry Project](https://github.com/chef/pantry-chef-repo)

## Usage

Run:
```
sudo ./bin/pantry
```

To perform the installation and run Chef with the default Policyfile.rb, use the `-c` option.

```
sudo ./bin/pantry -c
```

### Installing Packages

`./bin/pantry` will use the Policyfile.rb to add these attributes to the node. Then update the Policyfile.lock.json and export the repository.

```
chef update
sudo rm -rf zero-repo && chef export zero-repo
cd zero-repo && sudo chef-client -z
```

### Note for MacOS Sierra

Apparently Sierra enables `tty_tickets` by default, which breaks `sudo` in some of the recipes. See [here](http://stackoverflow.com/a/39474612) for more info.

In order to fix, you'll need to disable it by adding the following with `sudo visudo`:

```
Defaults    !tty_tickets
```
