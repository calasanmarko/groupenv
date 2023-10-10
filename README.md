# groupenv
Sets groups of environment variables according to a config file. Currently just a bash script, Windows support coming soon.

# Installation
Available as a npm package.

```
npm install -g groupenv
```

# Configuration
Sample configuration file:
```
{
  "groups": {
    "dev": [
      { "ENV1": "DEV_VAL" },
      { "ENV2": "DEV_VAL_2" }
    ],
    "stage": [
      { "ENV1": "STAGE_VAL" }
    ],
    "prod": [
      { "ENV1": "PROD_VAL" },
      { "ENV3": "SOMETHING" }
    ]
  }
}
```

# Usage
```
Usage:
  groupenv <group-name> [-q]
  groupenv <group-name> <config-file> [-q]

Options:
  -q: Quiet mode (suppress output except for errors)

Applies all environment variables under the given group.
By default, the script looks for 'groupenv.json' in the current directory.
```


# License
Made by Marko Calasan, 2022.

This product is licensed under the **MIT License**.
