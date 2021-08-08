FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build

EXPOSE 80

EXPOSE 443

WORKDIR /src

COPY *.sln .

COPY /api/*.csproj ./api/

RUN dotnet restore

COPY api/. ./api/

WORKDIR /src/api

RUN dotnet publish -c release -o /bin

FROM mcr.microsoft.com/dotnet/aspnet:5.0

WORKDIR /bin

COPY --from=build /bin ./

ENTRYPOINT ["dotnet", "api.dll"]