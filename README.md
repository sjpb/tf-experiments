Idea is that there are two directions of abstraction:

- `parent/modules/` contains base modules, `child/` derives specific instances of these (e.g. DEV, PROD etc).
- `infra` defines persistent resources (e.g. volumes, floating IPs), `cluster` defines recreatable ones.

This basically uses `infra` to define anything which would normally be listed as pre-requisites for `cluster`-creation.

It allows `cluster` to be deleted/recreated as required.
