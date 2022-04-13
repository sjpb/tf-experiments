Idea is that there are two directions of abstraction:

- `parent/modules/` contains base modules, `child/` derives specific instances of these (e.g. DEV, PROD etc).
- `infra` defines persistent resources (e.g. volumes, floating IPs), `cluster` defines recreatable ones.

This basically uses `infra` to define anything which would normally be listed as pre-requisites for `cluster`-creation.

It allows `cluster` to be deleted/recreated as required.

To create:

```
cd child/infra
terraform init
terraform apply
cd ../cluster
terraform init
terraform apply
```

Notes:
- You can't just `tf apply` in `cluster` - complains things aren't available.
- Using an infra module instead of a `data.terraform_remote_state` resource in `child/cluster` doesn't work - that just means that (if apply has been run in child/infra already) a second set of infra resources get created.
