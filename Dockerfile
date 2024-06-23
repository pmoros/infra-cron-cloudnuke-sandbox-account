FROM amazon/aws-cli:2.13.2

ENV DISABLE_TELEMETRY=true
ENV AWS_DEFAULT_REGION=us-east-1

WORKDIR /app

# Install the binary
COPY bin/cloud-nuke_linux_amd64 cloud-nuke

RUN yum install jq -y
# Add deployment script
COPY deploy/cloud-nuke.sh cloud-nuke.sh

# Set the binary as executable
RUN chmod +x cloud-nuke
RUN chmod +x cloud-nuke.sh

# Run the binary with like cloud-nuke --help
ENTRYPOINT [ "bash", "cloud-nuke.sh"]