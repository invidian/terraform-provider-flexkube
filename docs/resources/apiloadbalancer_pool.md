# API Load Balancer Pool Resource

This resource allows to create one or more Kubernetes API Load balancer containers on remote hosts over SSH using Docker container runtime.

## Example Usage

```hcl
resource "flexkube_apiloadbalancer_pool" "controllers" {
  name             = "api-loadbalancer-controllers"
  host_config_path = "/etc/haproxy/controllers.cfg"
  bind_address     = "0.0.0.0"
  servers          = ["10.0.0.10:6443"]

  ssh {
    port        = 22
    user        = "core"
  }

	api_load_balancer {
    host {
      ssh {
        address = "10.0.0.10"
      }
    }
  }
}
```

## Argument Reference

* `servers` - (Required) A list of Kubernetes API Server addresses with ports, which should be the target of the load balancer.

* `name` - (Optional) Unique identifier of the load balancers on the host. If you deploy more than one instance of load balancer on a single machine this must be defined to avoid the instances colliding.

* `host_config_path` - (Optional) Path where to store instance configuration file. If you deploy more than one instance of load balancer on a single machine, this must be defined to avoid configuration files collisions.

* `bind_address` - (Optional) Address on which the load balancer should bind for incoming requests.

* `api_load_balancer` - (Required) A `api_load_balancer` block as defined below. This block defines single API Load Balancer instance and can be specified multiple times.

* `image` - (Optional) Docker image with tag to be used to run HAProxy container. Defaults to `libflexkube` [default HAProxy Image](https://github.com/flexkube/libflexkube/blob/master/pkg/defaults/defaults.go#L12).

* `ssh` - (Optional) A `ssh` block as defined below. This block defines global SSH settings shared by all instances.

---

A `api_load_balancer` block supports the following:

* `host` - (Optional) A `host` block as defined below. This block defines where to connect for creating the container.

* `servers` - (Required) A list of Kubernetes API Server addresses with ports, which should be the target of the load balancer.

* `name` - (Optional) Unique identifier of the load balancers on the host. If you deploy more than one instance of load balance
r on a single machine this must be defined to avoid the instances colliding.

* `host_config_path` - (Optional) Path where to store instance configuration file. If you deploy more than one instance of load balancer on a single machine, this must be defined to avoid configuration files collisions.

* `bind_address` - (Optional) Address on which the load balancer should bind for incoming requests.

* `image` - (Optional) Docker image with tag to be used to run HAProxy container. Defaults to `libflexkube` [default HAProxy Image](https://github.com/flexkube/libflexkube/blob/master/pkg/defaults/defaults.go#L12).

---

A `host` block supports the following:

* `direct` - (Optional) A `direct` block as defined below. Mutually exclusive with all other fields in this block. If defined, container will be created on local machine.

* `ssh` - (Optional) A `ssh` block as defined below. Mutually exclusive with all other fields in this block. If defined, container will be created on a remote machine using SSH connection.

---

A `direct` block does not support any arguments.

---

A `ssh` block supports the following:

* `address` - (Required) An address where SSH client should connect to. Can be either hostname of IP address.

* `port` - (Optional) Port where to open SSH connection. Defaults to `22`.

* `user` - (Optional) Username to use when opening SSH connection. Defaults to `root`.

* `password` - (Optional) Password to use for SSH authentication. Can be combined with `private_key` and SSH agent authentication methods.

* `connection_timeout` - (Optional) Duration for how long to wait before connection attempts times out, expressed in [Go Duration format](https://golang.org/pkg/time/#ParseDuration). Defaults to `30s`.

* `retry_timeout` - (Optional) Duration for how long to wait before giving up on connection attempts, expressed in [Go Duration format](https://golang.org/pkg/time/#ParseDuration). Defaults to `60s`.

* `retry_interval` - (Optional) Duration for how long to wait between connection attempts, expressed in [Go Duration format](https://golang.org/pkg/time/#ParseDuration). Defaults to `1s`.

* `private_key` - (Optional) PEM encoded privat key to be used for authentication. Can be combined with `password` and SSH agent authentication methods.

## Attribute Reference

* `state` - Sanitized version of the state representing generated configuration to the user in Terraform-native format.

* `state_sensitive` - State used by the provider to track created containers etc.

* `state_yaml` - State of created containers in YAML format. Can be dumped to a `state.yaml` file and used together with `flexkube kubelet-pool` command.

* `config_yaml` - Generated configuration in YAML format, which can be used by the `flexkube kubelet-pool` command.
