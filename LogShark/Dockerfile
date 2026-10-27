FROM mcr.microsoft.com/dotnet/sdk:8.0-bookworm-slim
WORKDIR /app
COPY . ./

RUN DEBIAN_FRONTEND=noninteractive \
&& apt-get update \
&& apt-get upgrade -y -qq --allow-unauthenticated \
        -o Dpkg::Options::="--force-confold" -y \
&& apt-get install awscli python3-pip -y
RUN pip3 install botocore --break-system-packages
RUN dotnet publish "LogShark/LogShark.csproj" -r linux-x64 --self-contained true -c Release /p:Version=4.2.5 /p:UpdateConfigurationSchema=true -o out

WORKDIR /app

ENTRYPOINT ["/bin/bash"]
CMD ["-c", "sleep infinity"]
