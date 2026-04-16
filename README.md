# FAST-Parsing-Service

## Building docker image 

```
docker build -t vesp-server:latest . --platform linux/amd64 
```

Then launch it: `docker run -d -p 1701:1701 vesp-server:latest`

Log: `docker logs -f [container id]`

Request type: `curl -X POST http://localhost:1701/parse -d '{
  "source": "import pandas as pd\n\ndf = pd.read_csv('data.csv')\nprint(df.head())"}' -H "Content-Type: application/json"`
