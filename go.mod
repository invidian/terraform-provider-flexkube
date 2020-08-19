module github.com/flexkube/terraform-provider-flexkube

go 1.15

require (
	github.com/coreos/etcd v3.3.24+incompatible // indirect
	github.com/flexkube/libflexkube v0.3.1
	github.com/google/go-cmp v0.5.1
	github.com/hashicorp/terraform-plugin-sdk v1.15.0
	k8s.io/client-go v11.0.0+incompatible // indirect
	sigs.k8s.io/yaml v1.2.0
)

replace (
	github.com/go-logr/logr => github.com/go-logr/logr v0.1.0
	github.com/googleapis/gnostic => github.com/googleapis/gnostic v0.4.0
	github.com/russross/blackfriday => github.com/russross/blackfriday v1.5.2
	go.etcd.io/etcd => go.etcd.io/etcd v0.5.0-alpha.5.0.20200425165423-262c93980547
	k8s.io/client-go => k8s.io/client-go v0.18.3
	k8s.io/kube-openapi => k8s.io/kube-openapi v0.0.0-20200204173128-addea2498afe
)
