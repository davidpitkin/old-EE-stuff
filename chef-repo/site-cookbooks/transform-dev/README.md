transform-dev Cookbook
======================
Transform development cookbook for testing deployment and setup with Chef


Requirements
------------

e.g.
#### packages
- `application` - transform-dev needs the base application cookbook
- `postgresql` - transform-dev needs the postgresql application cookbook
- `apache2` - transform-dev needs the apache2 cookbook
- `passenger_apache2` - transform-dev needs the passenger_apache2 cookbook

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### transform-dev::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['transform-dev']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### transform-dev::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `transform-dev` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[transform-dev]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
