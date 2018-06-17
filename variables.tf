
variable "recordsets" {
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  description = "List of DNS recordset objects, in the standard terraformdns structure, to format into a zone file."
}
