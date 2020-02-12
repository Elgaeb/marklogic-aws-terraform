# TODO

* Add ability to define custom ports to open in the security group and load balancer.
* Refactor server groups so that a server group can support multiple availability zones.
    1. Move the code in the `marklogic/modules/server-group` to `marklogic/modules/server-group/modules/server-asg`.
    2. Change `marklogic/modules/server-group` to spread the grop over multiple availability zones.

# Notes


## Downloading the node manager lambda function

[MarkLogic 9.0-9.3](https://s3.amazonaws.com/marklogic-lambda-us-east-1/9.0-9.3/node_manager.zip)

[MarkLogic 10.0-3](https://s3.amazonaws.com/marklogic-lambda-us-east-1/10.0-3/node_manager.zip)


## Regular Expression for MarkLogic AMIs

```regexp
^\s*([\w-]+)\s*:\s*(\w+)\s*:\s*(ami-\w+)$
```

```
"v10.0-2.1.$1.$2"\t= "$3"
```
