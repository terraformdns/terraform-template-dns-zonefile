module "under_test" {
  source = "../.."

  recordsets = [
    {
      name    = "foo"
      type    = "A"
      ttl     = 300
      records = ["10.1.2.1"]
    },
    {
      name    = "mail"
      type    = "CNAME"
      ttl     = 300
      records = ["foo"]
    },
  ]
}

data "testing_assertions" "result" {
  subject = "Rendered zonefile"

  equal "result" {
    statement = "Produced the expected zonefile content"

    got  = module.under_test.rendered
    want = <<-EOT
      foo 300 IN A 10.1.2.1
      mail 300 IN CNAME foo
    EOT
  }
}
