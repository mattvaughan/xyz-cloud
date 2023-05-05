FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

RUN mkdir /build /build-output
WORKDIR /build
COPY src/Xyz.Api .
RUN dotnet publish -o /build-output

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final

RUN mkdir /app
COPY --from=build /build-output /app
ENTRYPOINT ["dotnet", "/app/Xyz.Api.dll"]
