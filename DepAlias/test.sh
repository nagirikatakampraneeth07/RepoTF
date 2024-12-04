resources=(
  "aws_s3_bucket.dependent"
)

for resource in "${resources[@]}"; do
  targets+=" -target=$resource"
done

terraform destroy $targets