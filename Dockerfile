# # Use an official ASP.NET Core runtime as a base image
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
# WORKDIR /app
# EXPOSE 80

# # Use the SDK image to build the application
# FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# WORKDIR /src
# COPY ["looks-api.csproj", "looks-api/"]
# RUN dotnet restore "looks-api/looks-api.csproj"
# COPY . .
# WORKDIR "/src/looks-api"
# RUN dotnet build "looks-api.csproj" -c Release -o /app/build

# # Publish the application
# FROM build AS publish
# RUN dotnet publish "looks-api.csproj" -c Release -o /app/publish

# # Create the final runtime image
# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "looks-api.dll"]

FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build-env
WORKDIR /app

COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "looks-api.dll"]