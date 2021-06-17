FROM mcr.microsoft.com/dotnet/sdk:2.1 as builder

WORKDIR /Vote
COPY Vote/Vote.csproj .
RUN dotnet restore

COPY /Vote .
RUN dotnet publish -c Release -o /out Vote.csproj

# app image
FROM mcr.microsoft.com/dotnet/aspnet:2.1

WORKDIR /app
ENTRYPOINT ["dotnet", "Vote.dll"]

COPY --from=builder /out .