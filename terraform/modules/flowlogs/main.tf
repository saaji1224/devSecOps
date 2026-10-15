resource "aws_cloudwatch_log_group" "vpc_flow_logs" {

  name              = "/aws/vpc/flowlogs"
  retention_in_days = 7

}


resource "aws_iam_role" "flowlogs_role" {

  name = "vpc-flowlogs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy" "flowlogs_policy" {

  name = "flowlogs-policy"

  role = aws_iam_role.flowlogs_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ]

        Resource = "*"
      }
    ]
  })
}


resource "aws_flow_log" "vpc_flow_log" {

  iam_role_arn    = aws_iam_role.flowlogs_role.arn

  log_destination = aws_cloudwatch_log_group.vpc_flow_logs.arn

  traffic_type    = "ALL"

  vpc_id = var.vpc_id



}
# # error and trouble shoot command
# module.eks.aws_eks_node_group.main: Creation complete after 1m17s [id=ecommerce-eks:ecommerce-eks-ng]
# ╷
# │ Error: creating CloudWatch Logs Log Group (/aws/vpc/flowlogs): operation error CloudWatch Logs: CreateLogGroup, https response error StatusCode: 400, RequestID: f6949267-645e-4df9-a7dd-2fe5d6f05098, ResourceAlreadyExistsException: The specified log group already exists
# │
# │   with module.flowlogs.aws_cloudwatch_log_group.vpc_flow_logs,
# │   on ..\..\modules\flowlogs\main.tf line 1, in resource "aws_cloudwatch_log_group" "vpc_flow_logs":
# │    1: resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
# │
# ╵
#  terraform import module.flowlogs.aws_cloudwatch_log_group.vpc_flow_logs "/aws/vpc/flowlogs"