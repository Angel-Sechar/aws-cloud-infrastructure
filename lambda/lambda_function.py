import os

def lambda_handler(event, context):
    detail  = event.get('detail', {})
    details = detail.get('Details', {})

    asg_name    = detail.get('AutoScalingGroupName', 'N/A')
    instance_id = detail.get('EC2InstanceId',        'N/A')
    cause       = detail.get('Cause',                'N/A')
    status      = detail.get('StatusCode',           'N/A')
    az          = details.get('Availability Zone',   'N/A')
    subnet      = details.get('Subnet ID',           'N/A')
    region      = event.get('region',                'N/A')
    time        = event.get('time',                  'N/A')

    message = f"""
Se ha creado una nueva instancia EC2 por el Grupo de auto escalabilidad {asg_name}.

Detalles:
- Fecha y hora:           {time}
- Region:                 {region}
- EC2 ID:                 {instance_id}
- Estado:                 {status}
- Zona de disponibilidad: {az}
- Subnet:                 {subnet}
- Motivo:                 {cause}
    """.strip()

    return {
        "status": "success",
        "subject": f"Nueva instancia lanzada en {asg_name}",
        "message": message
    }