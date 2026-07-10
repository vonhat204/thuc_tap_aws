$vpcId = "vpc-08f49243da9f25c83"
$winSgId = "sg-002667e363708a28c"
$linuxSgId = "sg-0992ab9575f2d182b"

# Create RDS Security Group (EC2 SG)
Write-Output "Creating RDS Security Group..."
$dbSgId = aws ec2 create-security-group --group-name "DB-SG-Week3" --description "SG for RDS Database" --vpc-id $vpcId --query "GroupId" --output text
aws ec2 authorize-security-group-ingress --group-id $dbSgId --protocol tcp --port 3306 --source-group $linuxSgId
aws ec2 authorize-security-group-ingress --group-id $dbSgId --protocol tcp --port 3306 --source-group $winSgId

# Create DB Subnet Group
Write-Output "Creating DB Subnet Group..."
aws rds create-db-subnet-group --db-subnet-group-name "Lab5-DB-Subnet-Group" --db-subnet-group-description "Subnet group for RDS" --subnet-ids subnet-0676c3f84852870d4 subnet-083d435c2a38d6c66 subnet-04d5407432a6560a0

# Launch RDS DB Instance (MySQL, db.t3.micro, 20GB)
Write-Output "Launching RDS instance..."
$rdsInstance = aws rds create-db-instance --db-instance-identifier "lab5-rds" --db-instance-class db.t3.micro --engine mysql --master-username admin --master-user-password "Admin12345" --allocated-storage 20 --vpc-security-group-ids $dbSgId --db-subnet-group-name "Lab5-DB-Subnet-Group" --no-multi-az --query "DBInstance.DBInstanceIdentifier" --output text

Write-Output "RDS DB creation initiated: $rdsInstance"
"dbSgId=$dbSgId`nrdsInstance=$rdsInstance" | Add-Content "scratch/week3_resources.txt"
