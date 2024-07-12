FROM public.ecr.aws/lambda/provided:al2

RUN yum install aws-cli -y
RUN yum install jq -y

ENV DISABLE_TELEMETRY=true
ENV AWS_DEFAULT_REGION=us-east-1

WORKDIR /app

# Install the binary
COPY bin/cloud-nuke_linux_amd64 cloud-nuke

# Add deployment script
COPY deploy/cloud-nuke.sh cloud-nuke.sh

# Set the binary as executable
RUN chmod +x cloud-nuke
RUN chmod +x cloud-nuke.sh

# Run the binary with like cloud-nuke --help
ENTRYPOINT [ "bash", "cloud-nuke.sh"]

CMD ["/bin/bash", "cloud-nuke.sh && curl --silent -X POST \"http://${AWS_LAMBDA_RUNTIME_API}/2018-06-01/runtime/invocation/${REQUEST_ID}/response\" -d 'SUCCESS'"]