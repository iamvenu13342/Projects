resource "aws_cloudwatch_log_group" "eks_log_group" {
  name              = "/aws/eks/my-eks-cluster/cluster"
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EKS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    ClusterName = aws_eks_cluster.main.name
  }

  alarm_actions = [aws_sns_topic.sns.arn]
}

resource "aws_sns_topic" "sns" {
  name = "MySNSTopic"
}
