data "template_file" "log_name" {
  template = "${path.module}/output.log"
}

data "template_file" "endpoint-id" {
  template = "${path.module}/id.log"
}

data "local_file" "createEndpoint" {
  filename = "${data.template_file.log_name.rendered}"
  depends_on = ["null_resource.createEndpoint"]
}

data "local_file" "readId" {
  filename = "${data.template_file.endpoint-id.rendered}"
  depends_on = ["null_resource.getId"]
}

resource "null_resource" "createEndpoint" {
  provisioner "local-exec" {
    command = "aws route53resolver create-resolver-endpoint --creator-request-id ${var.creator-request-id} --security-group-ids ${local.security-groups} --direction ${var.direction} --ip-addresses ${local.ip-list} --name ${var.endpoint-name} --tags ${var.tags} --profile ${var.aws-profile} > ${data.template_file.log_name.rendered}"
  }
}


resource "null_resource" "getId" {
  provisioner "local-exec" {
    command = "aws route53resolver list-resolver-endpoints --profile ${var.aws-profile} --output text --query ResolverEndpoints[?Name=='${var.endpoint-name}'].Id > ${data.template_file.endpoint-id.rendered}"
  }
  depends_on = ["null_resource.createEndpoint"]
}

data "template_file" "ips" {
  count = "${length(var.subnet-ids)}"
  template = "SubnetId=${var.subnet-ids[count.index]},Ip=${var.ip_addresses[count.index]} "
}

data "template_file" "security-groups" {
  count = "${length(var.security-groups)}"
  template = "${var.security-groups[count.index]} "
}

locals {
  ip-list = "${join(" ",data.template_file.ips.*.rendered)}"
  security-groups = "${join(" ",data.template_file.security-groups.*.rendered)}"
}

resource "null_resource" "deleteEndpoint" {
  count = "${var.delete != "false" ? 1 :0}"
  provisioner "local-exec" {
    command = "aws route53resolver delete-resolver-endpoint resolver-endpoint-id ${trimspace(data.local_file.readId.content)} --profile ${var.aws-profile} > ${data.template_file.log_name.rendered}"
  }
  depends_on = ["null_resource.createEndpoint"]
}
