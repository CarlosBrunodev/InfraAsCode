variable instance_type {
  type        = string
  default     = "t2.micro"
  description = "Maquina utilizado na instancia"
}

variable ami {
  type        = string
  default     = "ami-0cf6f5c8a62fa5da6"
  description = "Configuracao da imagem"
}

variable min_size {
  type        = number
  default     = ""
  description = "Numero minimo de instancias"
}

variable max_size {
  type        = number
  default     = ""
  description = "Numero maximo de instancias"
}

variable desired_capacity {
  type        = number
  default     = ""
  description = "Numero de capacidade ideal"
}

