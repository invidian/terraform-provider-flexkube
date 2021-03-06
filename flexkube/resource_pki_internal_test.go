package flexkube

import (
	"testing"

	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/resource"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
)

func TestPKI(t *testing.T) {
	t.Parallel()

	config := `
resource "flexkube_pki" "pki" {
	etcd {
		peer_certificates {
			common_name = "foo"
			certificate {
				organization = "foo"
			}
		}
	}

	kubernetes {}
}
`

	resource.UnitTest(t, resource.TestCase{
		Providers: map[string]*schema.Provider{
			"flexkube": Provider(),
		},
		Steps: []resource.TestStep{
			{
				Config:             config,
				ExpectNonEmptyPlan: true,
			},
		},
	})
}
