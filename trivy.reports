#!/bin/bash

echo "Pulling Docker image from Docker Hub"
docker pull ronak1907/webapp:latest

echo "Scanning Docker image using Trivy"
wget https://github.com/aquasecurity/trivy/releases/download/v0.18.3/trivy_0.18.3_Linux-64bit.deb 
sudo dpkg -i trivy_0.18.3_Linux-64bit.deb

trivy -v
trivy --severity HIGH --exit-code 30 ronak1907/webapp:latest

high_severity_count=$(trivy --severity HIGH --quiet --format template --template "{{ len .Vulnerabilities }}" ronak1907/webapp:latest)
echo "High Severity Vulnerabilities Count: $high_severity_count"

if [ "$high_severity_count" -gt 30 ]; then
  echo "High Severity Vulnerabilities exceed the threshold. Failing the pipeline."
  exit 1
else
  echo "Pipeline continues as High Severity Vulnerabilities are within the threshold."
fi

aws s3 cp trivy.reports s3://trivy-scan-bucket/trivy.reports
aws sns publish --topic-arn "arn:aws:sns:ap-south-1:149815208654:trivy_scan_mail" --subject "Trivy Report" --message "Trivy report is available at https://trivy-scan-bucket.s3.ap-south-1.amazonaws.com/trivy.reports"
