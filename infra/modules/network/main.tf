resource "random_pet" "network" {
  prefix = var.network_name
  length = 2
}


resource "random_pet" "subnet" {
  prefix = "cloudnotes-subnet"
  length = 2
}


resource "local_file" "network" {
  filename = "network.txt"

  content = <<EOF
Network Name : ${random_pet.network.id}
Subnet ID    : ${random_pet.subnet.id}
EOF
}
