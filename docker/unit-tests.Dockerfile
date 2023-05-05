FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

RUN mkdir /build /build-output
WORKDIR /build
COPY src/ .

ENTRYPOINT ["dotnet", "test", "Xyz.UnitTests/Xyz.UnitTests.csproj"]
