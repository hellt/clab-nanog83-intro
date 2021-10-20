This repo augments the [Containerlab](https://containerlab.srlinux.dev) presentation delivered at NANOG 83.

It contains the files needed to deploy a BGP Route Reflection lab and execute the use case.

![pic](https://gitlab.com/rdodin/pics/-/wikis/uploads/7fb73b48cfca59e0c07bbfe79180617c/image.png)

## Deploying a lab
Clone this repository, change into `clab-nanog83-intro` directory and execute

```
containerlab deploy -t rr.clab.yml
```

## Executing the use case
Once the lab deployment finishes, make goBGP peer to announce its route by doing:

```
docker exec clab-rr-gobgp bash /gobgp.sh
```

## Verifying route reflection operation
On SR Linux node, check that the route announced by goBGP has been received via Arista cEOS acting as a route reflector:

```
docker exec clab-rr-srlinux sr_cli "show network-instance default protocols bgp neighbor 192.168.11.2 received-routes ipv4"
```

## Destroying a lab
Do `containerlab destroy -t rr.clab.yml`
