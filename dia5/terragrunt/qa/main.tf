# Modulo dentro do filesystem local
module "webserver_cluster" {
    source                       = "../modules/webserver-cluster"

    instance_type                = var.instance_type
    mensagem                     = var.mensagem
    alb_name                     = var.alb_name
    instance_security_group_name = var.instance_security_group_name
    alb_security_group_name      = var.alb_security_group_name
    asg_desired_capacity         = var.asg_desired_capacity
    asg_min_size                 = var.asg_min_size
    asg_max_size                 = var.asg_max_size
    habilitar_autoscale          = true
    region                       = var.region
}

