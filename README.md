squidguard Cookbook
===================
This cookbook installs and configures squidGuard.  It was written as a series of cookbooks to install critical portions of my personal web filter.

TODO: acl lists, filtering based on acls

Requirements
------------

The cookbook has been written to be independent of other cookbooks.  I use a wrapper cookbook to add additional functionality, like integrating with the squid cookbook.

Attributes
----------
#### squidguard::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['squidguard']['blacklist']</tt></td>
    <td>String</td>
    <td>Blacklist to use.  Valid options are shallalist, mesd, and toulouse</td>
    <td><tt>shallalist</tt></td>
  </tr>
  <tr>
    <td><tt>['squidguard']['filter']</tt></td>
    <td>Array</td>
    <td>Categories to block.  These are all contained in the blacklist distribution file</td>
    <td><tt>porn, warez</tt></td>
  </tr>
  <tr>
    <td><tt>['squidguard']['redirect']</tt></td>
    <td>String</td>
    <td>URL to redirect blocked URLs to</td>
    <td><tt>http://www.example.com/bad_url.html</tt></td>
  </tr>
</table>

Usage
-----

Just include `squidguard` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[squidguard]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Author: Chris Cureau
