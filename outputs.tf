output "aws-cli-output" {
  value = "${data.local_file.create-endpoint.content}"
}

output "endpoint-id" {
  value = "${trimspace(data.local_file.readId.content)}"
}
