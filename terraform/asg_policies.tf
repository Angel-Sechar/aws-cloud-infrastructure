resource "aws_autoscaling_policy" "scale_out" {
  name                   = "ASG-EC2-APP-StepScaleOut"
  autoscaling_group_name = aws_autoscaling_group.main.name
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"

  step_adjustment {
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = 10
    scaling_adjustment          = 1
  }

  step_adjustment {
    metric_interval_lower_bound = 10
    metric_interval_upper_bound = 20
    scaling_adjustment          = 2
  }

  step_adjustment {
    metric_interval_lower_bound = 20
    scaling_adjustment          = 3
  }
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "ASG-EC2-APP-StepScaleIn"
  autoscaling_group_name = aws_autoscaling_group.main.name
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"

  step_adjustment {
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = 10
    scaling_adjustment          = -1
  }

  step_adjustment {
    metric_interval_lower_bound = 10
    scaling_adjustment          = -2
  }
}
