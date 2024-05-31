# Build base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env

# Set the working directory
WORKDIR /App

# Copy everything
COPY . ./

# Restore as distinct layers
RUN dotnet restore

# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Set the working directory
WORKDIR /App

# Copy the published output from the build image
COPY --from=build-env /App/out .

# Set the entry point for the container
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
