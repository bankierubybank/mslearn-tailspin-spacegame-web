# https://hub.docker.com/_/microsoft-dotnet
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY Tailspin.SpaceGame.Web/*.csproj .
RUN dotnet restore 

# copy everything else and build app
COPY Tailspin.SpaceGame.Web/. .
RUN dotnet publish -c Release -o /app --self-contained false --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Tailspin.SpaceGame.Web.dll"]