
$GOPATH="c:\gopath"

# Install dep to enable the deps target in Telegraf's Makefile.
curl -L -s https://github.com/golang/dep/releases/download/v0.5.0/dep-windows-amd64.exe -o $GOPATH/bin/dep.exe
ICACLS $GOPATH/bin/dep.exe /grant:r "users:(RX)" /C


# Build telegraf dcos fork under the original package path
$project="github.com/influxdata/telegraf"
$project_src_path="$GOPATH/src/$project"
# Add the project to $GOPATH.
mkdir -p $(dirname $project_src_path)
copy-item -recurse  -Path c:/pkg/src/dcos/telegraf/ -Destination c:/gopath/src/github.com/influxdata/telegraf/

# Windows Build
Push-Location $project
$env:GOOS = "windows"
make deps && go build .

new-item -itemtype directory "$env:PKG_PATH/bin"
Copy-Item -Path "$project/telegraf.exe" -Destination "$env:PKG_PATH/bin/telegraf.exe"

Pop-Location
