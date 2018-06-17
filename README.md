# DNS Zonefile Template Module

The module can format a DNS recordset into DNS zonefile syntax.
It is part of [the `terraformdns` project](https://terraformdns.github.io/).

## Example Usage

```hcl
module "dns_zonefile" {
  source = "terraformdns/dns-zonefile/template"

  recordsets = [
    {
      name    = "www"
      type    = "A"
      ttl     = 3600
      records = [
        "192.0.2.56",
        "192.0.2.57",
        "192.0.2.58",
      ]
    },
  ]
}

output "zonefile" {
  value = module.dns_zonefile.rendered
}
```

With the above configuration, the output `zonefile` would have the following
value:

```
foo 300 IN A 1.2.3.4
foo 300 IN A 5.6.7.8
```

## Compatibility

When using this module, always use a version constraint that constraints to at
least a single major version. Future major versions may have new or different
required arguments, and may produce zone file strings which are functionally
equivalent by not character-for-character identical.

## Arguments

- `recordsets` is a list of DNS recordsets in the standard `terraformdns`
  recordset format.

This module works within Terraform only and does not require any providers
nor access any external services.
