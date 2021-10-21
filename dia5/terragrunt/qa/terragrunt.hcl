include "root" {
  path = find_in_parent_folders()
}

inputs = {
  instance_type = "t2.micro"
  mensagem      = "Olá, ${path_relative_to_include()}"
  alb_name      = "alb-terragrunt-${path_relative_to_include()}"
  instance_security_group_name = "sginstance-terragrunt-${path_relative_to_include()}"
  alb_security_group_name = "sgalb-terragrunt-${path_relative_to_include()}"
  asg_desired_capacity = 1
  asg_min_size = 1
  asg_max_size = 1 
}