resource "aws_key_pair" "cmtr_ook9q7ho_keypair" {
  key_name   = "cmtr-ook9q7ho-keypair"
  public_key = var.ssh_key

  tags = {
    Project = "epam-tf-lab"
    ID      = "cmtr-ook9q7ho"
  }
}
