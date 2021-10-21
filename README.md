This repo augments the [Containerlab](https://containerlab.srlinux.dev) presentation delivered at NANOG 83.

It contains the files needed to deploy a BGP Route Reflection lab and execute the use case.

![pic](https://gitlab.com/rdodin/pics/-/wikis/uploads/7fb73b48cfca59e0c07bbfe79180617c/image.png)

The following use cases and the corresponding topology files are provided:

1. Manual node configuration - [`rr.clab.yml`](https://github.com/hellt/clab-nanog83-intro/blob/main/rr.clab.yml)  
    In this scenario the lab nodes come up online with a default configuration, letting a user to provision the interfaces and BGP manually.
2. Fully provisioned lab -- [`rr.provisioned.clab.yml`](https://github.com/hellt/clab-nanog83-intro/blob/main/rr.provisioned.clab.yml)  
    The nodes boot up with a startup configuration provided with `startup-config` instruction in the topology file. All a user needs to do is to let goBGP to start announcing the route.

## Deploying a lab
Clone this repository, change into `clab-nanog83-intro` directory and execute

```bash
# for use case #1 - manual configuration
containerlab deploy -t rr.clab.yml

# for use case #2 - fully provisioned lab
containerlab deploy -t rr.provisioned.clab.yml
```

## Executing the use case
Once the lab deployment finishes, configure the interfaces and protocols (if use case #1 was selected) and make goBGP peer to announce its route by doing:

```
docker exec clab-rr-gobgp bash /gobgp.sh
```

## Verifying route reflection operation
On SR Linux node, check that the route announced by goBGP has been received via Arista cEOS acting as a route reflector:

```
docker exec clab-rr-srlinux sr_cli "show network-instance default protocols bgp neighbor 192.168.11.2 received-routes ipv4"
```

## Destroying a lab
Do `containerlab destroy -t rr.clab.yml --cleanup`
