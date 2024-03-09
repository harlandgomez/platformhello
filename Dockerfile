FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /build
COPY ["sampleweb/sampleweb.csproj", "./sampleweb/"]
RUN dotnet restore "sampleweb/sampleweb.csproj"
COPY sampleweb/. ./sampleweb/
WORKDIR "/build/sampleweb"
RUN dotnet build "sampleweb.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "sampleweb.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "sampleweb.dll"]
