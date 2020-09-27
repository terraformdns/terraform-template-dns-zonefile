
terraform {
  required_version = ">= 0.12.0"
}

locals {
  records = flatten(concat([
    for rs in var.recordsets : [
      for r in rs.records : {
        name = rs.name
        type = rs.type
        ttl  = rs.ttl
        data = r
      }
    ]
  ]))

  # We create an intermediate set of strings here because iterating it
  # below will then be in lexical order, rather than the
  # undefined-but-consistent order that sets of objects iterate in.
  records_raw = toset([
    for r in local.records : "${r.name} ${r.ttl} IN ${r.type} ${r.data}"
  ])

  zonefile = <<EOT
%{~for rr in local.records_raw~}
${rr}
%{endfor~}
EOT

}

output "rendered" {
  value = local.zonefile
}
