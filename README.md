### Crear aplicación

```bash
mkdir backend && cd backend

dotnet new sln
```

### Crear proyecto

```bash
mkdir api && cd api

dotnet new webapi
```

### Linkear proyecto a la solución

```bash
cd ..

dotnet sln backend.sln add ./api/api.csproj
```

### Ejecutar aplicación

```bash
dotnet run
```

[https://localhost:5001/swagger](https://localhost:5001/swagger)

### Crear archivo Dockerfile

```bash
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
```

### Crear imágen

```bash
docker build -t backend:dev .
```

### Revisar imágen

```bash
docker images
```

### Ejecutar

```bash
docker run --rm -it -d -p 5000:80 backend:dev
```

### Chequear funcionamiento

[http://localhost:5000/weatherforecast](http://localhost:5000/weatherforecast)
