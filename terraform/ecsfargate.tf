resource "aws_ecs_cluster" "store_cluster" {
  name = "store-cluster"
}

resource "aws_ecs_task_definition" "store_task" {
  family                   = "store-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "store-api",
      image = "<account_id>.dkr.ecr.us-east-1.amazonaws.com/devops-store-backend:latest", # Imagem do backend
      portMappings = [
        {
          containerPort = 3000,
          hostPort      = 3000,
          protocol      = "tcp"
        }
      ],
      environment = [
        { name = "PORT", value = "3000" },
        { name = "DB_HOST", value = "${aws_db_instance.postgres.address}" },
        { name = "DB_PORT", value = "${aws_db_instance.postgres.port}" },
        { name = "DB_USER", value = "${local.db_credentials.username}" },
        { name = "DB_PASSWORD", value = "${local.db_credentials.password}" },
        { name = "DB_NAME", value = "${local.db_credentials.db_name}" }
      ]
    },
    {
      name  = "store-populate",
      image = "<account_id>.dkr.ecr.us-east-1.amazonaws.com/devops-store-populate:latest", # Imagem do populate
      environment = [
        { name = "DB_HOST", value = "${aws_db_instance.postgres.address}" },
        { name = "DB_PORT", value = "${aws_db_instance.postgres.port}" },
        { name = "DB_USER", value = "${local.db_credentials.username}" },
        { name = "DB_PASSWORD", value = "${local.db_credentials.password}" },
        { name = "DB_NAME", value = "${local.db_credentials.db_name}" }
      ]
    }
  ])
}

resource "aws_ecs_service" "store_service" {
  name            = "store-service"
  cluster         = aws_ecs_cluster.store_cluster.id
  task_definition = aws_ecs_task_definition.store_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.store_subnet.id]
    security_groups  = [aws_security_group.store_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.store_tg.arn
    container_name   = "store-api"
    container_port   = 3000
  }

  depends_on = [
    aws_lb_listener.store_listener
  ]
}
