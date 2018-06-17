
terraform {
  required_version = ">= 0.12.0"
}

locals {
  records = concat([
    for rs in var.recordsets : [
      for r in rs.records : {
        name = rs.name
        type = rs.type
        ttl  = rs.ttl
        data = r
      }
    ]
  ]...)

  zonefile = <<EOT
%{~for k, r in local.records~}
${r.name} ${r.ttl} IN ${r.type} ${r.data}
%{ endfor~}
EOT  

}

output "rendered" {
  value = local.zonefile
}
