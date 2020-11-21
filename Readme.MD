# ec2 terraform and ansible docker web

## Prerequisites
* anisble > 2.8
* python3
* terraform
* aws credentials

## Create EC2 Instance in AWS

### First create ssh file for ec2 instance
`ssh-keygen -t rsa -b 4096 -C "<your_email>"`

Copy content of created ssh public file and update ssh_public_key in server/main.tf file

### Set AWS environment variables in terminal

You can provide your credentials via the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY, environment variables
```
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_DEFAULT_REGION="us-west-2"
```

### Run terraform
```
cd server
terraform init
terraform plan
terraform apply
```

You will get output like

```
instance_id = <instance_id>
key_name = my-server-ssh-key
public_ip = <public_ip_of_ec2_instance>
```

## Set hosts file for installation

Add public_ip and ssh_private_file_location in  `setup/inventories/web/hosts` file.


## Run ansible playbook

```
cd setup
ansible-playbook -i inventories/web setup.yml
```

After that, You can see these applications are running on following ports:
```
website: http://<public_ip>:8080
nginx-prometheus-exporter: http://<public_ip>:9113/prometheus
prometheus: http://<public_ip>:9090/graph
grafana: http://<public_ip>:3000
```


### Grafana dashboard configuration
* Login to grafana, username: `admin`, password: `admin`
* Import dashboard using `11280` id.
* Select DS_PROMETHEUS = `Prometheus`
* Now you can see some metrics form nginx
