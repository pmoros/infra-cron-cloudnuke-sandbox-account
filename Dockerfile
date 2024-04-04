FROM ubuntu:22.04

ENV DISABLE_TELEMETRY=true

WORKDIR /app
# Install the binary
COPY bin/cloud-nuke_linux_amd64 cloud-nuke

# Set the binary as executable
RUN chmod +x cloud-nuke

# Run the binary with like cloud-nuke --help
ENTRYPOINT [ "/app/cloud-nuke", "aws", "--region", "us-east-1", "--region", "us-east-2", "--region", "us-west-1", "--region", "us-west-2", "--dry-run"]