# FAST-Parsing-Service

## Load baseline
```
Metacello new
    githubUser: 'MLProfile' project: 'FAST-Parsing-Service' commitish: 'main' path: 'src';
    baseline: 'FastParsingAPI';
    load
```

## Building docker image 

```
docker build -t vesp-server:latest . --platform linux/amd64 
```

Then launch it: `docker run -d -p 1701:1701 vesp-server:latest`

Log: `docker logs -f [container id]`

## Pulling from GitHub

```
docker pull ghcr.io/mlprofile/fast-parsing-service:main
docker run -d --platform linux/amd64 -p 1701/1701 ghcr.io/mlprofile/fast-parsing-service:main
```

## Request type 
Request:
```
curl -X POST http://localhost:1701/parse -d '{
  "source": "import pandas as pd\n\ndf = pd.read_csv('data.csv')\nprint(df.head())"}' -H "Content-Type: application/json"`
```

Response:
```
[{"source":"import pandas as pd","line":{"start":1,"end":1},"step_name":"Library Loading","library":"","id":"fc82fb79-f50b-0e00-8a1d-7c5b0ba24e40","function":"","cursor":{"start":1,"end":19}},{"source":"pd.read_csv(data.csv)","line":{"start":3,"end":3},"step_name":"","library":"","id":"0285fb79-f50b-0e00-8a1e-a3ae0ba24e40","function":"","cursor":{"start":27,"end":47}},{"source":"print(df.head())","line":{"start":4,"end":4},"step_name":"","library":"","id":"5a86fb79-f50b-0e00-8a1f-09d20ba24e40","function":"","cursor":{"start":49,"end":64}},{"source":"df.head()","line":{"start":4,"end":4},"step_name":"","library":"","id":"9586fb79-f50b-0e00-8a20-29c20ba24e40","function":"","cursor":{"start":55,"end":63}}]
```

ToDo: 

- Project baseline
- Settings to choose between instruction and bloc parsing
- Mooving json construction to Server class
- Dockerfile sould download a raw moose 13 image and load the project 
