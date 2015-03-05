evt-word-import-tool Cookbook
=============================
Chef cookbook to install the EVT Word document import tool

Requirements
------------

#### packages
- `application` - chef generic application cookbook
- `application_python` - chef Django cookbook running on Gunicorn


Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### evt-word-import-tool::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['evt-word-import-tool']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### evt-word-import-tool::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `evt-word-import-tool` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[evt-word-import-tool]"
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
Authors: Luke Scott [luke at cronworks dot net]
