# reposync

Cookbook to quickly setup yum repo mirrors

## Supported Platforms

Tested And Validated On
- CentOS 7.x

## Usage

Setup a system registered to all the repos you would like to mirror.  Then `include_recipe 'reposync::default'` to automatically start mirroring those repos.

### reposync::default

Include `reposync` in your run_list.

```json
{
  "run_list": [
    "recipe[reposync::default]"
  ]
}
```

## Testing

* Linting - Rubocop and Foodcritic
* Spec - ChefSpec
* Integration - Test Kitchen

Testing requires [ChefDK](https://downloads.chef.io/chef-dk/) be installed using it's native gems.

```
foodcritic -f any -X spec .
rubocop
rspec --color --format progress
```

If you run into issues testing please first remove any additional gems you may
have installed into your ChefDK environment.  Extra gems can be found and removed
at `~/.chefdk/gem`.

## License and Authors

Author:: Jacob McCann (<jacob.mccann2@target.com>)

```text
Copyright (c) 2016 Jacob McCann, All Rights Reserved.
```
