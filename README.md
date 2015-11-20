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
chef export --force zero-repo
sudo chef-client -z
```
