
variable "recordsets" {
  type = set(object({
    name    = string
    type    = string
    ttl     = number
    records = set(string)
  }))
  description = "Set of DNS recordset objects, in the standard terraformdns structure, to format into a zone file."
}
