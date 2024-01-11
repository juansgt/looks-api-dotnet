# Use the official .NET SDK image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy only the project file and restore as a distinct layer
COPY looks-api/*.csproj ./looks-api/
RUN dotnet restore looks-api/looks-api.csproj

# Copy everything else and build the application
COPY . .

# Change the working directory to the project directory
WORKDIR /source/looks-api

# Build the application
RUN dotnet publish -c release -o /app --no-restore

# Use the official .NET Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy the published application
COPY --from=build /app ./

# Set the entry point
ENTRYPOINT ["dotnet", "looks-api.dll"]