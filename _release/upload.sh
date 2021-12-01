#!/usr/local/bin/bash

git_root=$(git rev-parse --show-toplevel)

function latest_version() {
    cat $git_root/README.md | awk '/gdrive-aix-ppc64/ {print $4}'
}

function description() {
    cat <<EOF
$ordinal_release release
- OAuth hotfix is included (using my own Google Drive v3 keys) you may see a warning message when getting your API key, you can safely ignore the message as I haven’t submitted my OAuth credentials for review to Google
- All possible binaries are built using [xgo](https://github.com/karalabe/xgo) and golang’s built in cross compile support although, they are not tested, YMMV
- So far, these are the only binaries that I’ve personally tested and is known to work
  * gdrive-linux-amd64 (Ubuntu 18.04.5 LTS, Debian 11.0 Unstable)
  * gdrive-ios-5.0-arm64 (Apple iPhone 6, Apple iPhone 7)
  * gdrive-darwin-amd64 (macOS Catalina 10.15.7, macOS Big Sur 11.6)
  * gdrive-windows-amd64.exe (Windows 7 Ultimate, Windows 10 Pro)
  * gdrive-android-16-arm (Android 5.1.1, Android 6.0.1, Android 7.1.1, Android 8.1.0)

- Merged upstream
- Bump version to v2.1.2
EOF
}

githubrelease --github-token $gjaw_token --progress release GrowtopiaJaw/gdrive create --name $gdrive_tag --body "$(description)" --publish $gdrive_tag

# Grab application version
VERSION=$(./gdrive-linux-amd64 version | awk 'NR==1 {print $2}')

declare -a filenames
filenames=(
    "gdrive-aix-ppc64"
    "gdrive-android-16-386"
    "gdrive-android-16-arm"
    "gdrive-darwin-10.6-386"
    "gdrive-darwin-amd64"
    "gdrive-dragonfly-amd64"
    "gdrive-freebsd-386"
    "gdrive-freebsd-amd64"
    "gdrive-freebsd-arm64"
    "gdrive-freebsd-armv6"
    "gdrive-freebsd-armv7"
    "gdrive-illumos-amd64"
    "gdrive-ios-5.0-arm64"
    "gdrive-ios-5.0-armv7"
    "gdrive-js-wasm"
    "gdrive-linux-386"
    "gdrive-linux-amd64"
    "gdrive-linux-arm64"
    "gdrive-linux-armv5"
    "gdrive-linux-armv6"
    "gdrive-linux-armv7"
    "gdrive-linux-mips64"
    "gdrive-linux-mips64le"
    "gdrive-linux-ppc64"
    "gdrive-linux-ppc64le"
    "gdrive-linux-riscv64"
    "gdrive-linux-s390x"
    "gdrive-netbsd-386"
    "gdrive-netbsd-amd64"
    "gdrive-netbsd-arm64"
    "gdrive-netbsd-armv6"
    "gdrive-netbsd-armv7"
    "gdrive-openbsd-386"
    "gdrive-openbsd-amd64"
    "gdrive-openbsd-arm64"
    "gdrive-openbsd-armv6"
    "gdrive-openbsd-armv7"
    "gdrive-plan9-386"
    "gdrive-plan9-amd64"
    "gdrive-plan9-arm"
    "gdrive-solaris-amd64"
    "gdrive-windows-386.exe"
    "gdrive-windows-amd64.exe"
    "gdrive-windows-arm.exe"
)

# Note: associative array requires bash 4+
declare -A descriptions
descriptions=(
    ["gdrive-aix-ppc64"]="AIX PowerPC 64-bit"
    ["gdrive-android-16-386"]="Android x86_64 32-bit"
    ["gdrive-android-16-arm"]="Android ARM 32-bit"
    ["gdrive-darwin-10.6-386"]="macOS x86_64 32-bit"
    ["gdrive-darwin-amd64"]="macOS x86_64 64-bit"
    ["gdrive-dragonfly-amd64"]="DragonFly x86_64 64-bit"
    ["gdrive-freebsd-386"]="FreeBSD x86_64 32-bit"
    ["gdrive-freebsd-amd64"]="FreeBSD x86_64 64-bit"
    ["gdrive-freebsd-arm64"]="FreeBSD ARM 64-bit"
    ["gdrive-freebsd-armv6"]="FreeBSD ARM 32-bit armv6"
    ["gdrive-freebsd-armv7"]="FreeBSD ARM 32-bit armv7"
    ["gdrive-illumos-amd64"]="illumos x86_64 64-bit"
    ["gdrive-ios-5.0-arm64"]="iOS ARM 64-bit"
    ["gdrive-ios-5.0-armv7"]="iOS ARM 32-bit armv7"
    ["gdrive-js-wasm"]="JavaScript WebAssembly"
    ["gdrive-linux-386"]="Linux x86_64 32-bit"
    ["gdrive-linux-amd64"]="Linux x86_64 64-bit"
    ["gdrive-linux-arm64"]="Linux ARM 64-bit"
    ["gdrive-linux-armv5"]="Linux ARM 32-bit armv5"
    ["gdrive-linux-armv6"]="Linux ARM 32-bit armv6"
    ["gdrive-linux-armv7"]="Linux ARM 32-bit armv7"
    ["gdrive-linux-mips64"]="Linux MIPS 64-bit"
    ["gdrive-linux-mips64le"]="Linux MIPS 64-bit le"
    ["gdrive-linux-ppc64"]="Linux PowerPC 64-bit"
    ["gdrive-linux-ppc64le"]="Linux PowerPC 64-bit le"
    ["gdrive-linux-riscv64"]="Linux RISC V 64-bit"
    ["gdrive-linux-s390x"]="Linux IBM S/390 64-bit"
    ["gdrive-netbsd-386"]="NetBSD x86_64 32-bit"
    ["gdrive-netbsd-amd64"]="NetBSD x86_64 64-bit"
    ["gdrive-netbsd-arm64"]="NetBSD ARM 64-bit"
    ["gdrive-netbsd-armv6"]="NetBSD ARM 32-bit armv6"
    ["gdrive-netbsd-armv7"]="NetBSD ARM 32-bit armv7"
    ["gdrive-openbsd-386"]="OpenBSD x86_64 32-bit"
    ["gdrive-openbsd-amd64"]="OpenBSD x86_64 64-bit"
    ["gdrive-openbsd-arm64"]="OpenBSD ARM 64-bit"
    ["gdrive-openbsd-armv6"]="OpenBSD ARM 32-bit armv6"
    ["gdrive-openbsd-armv7"]="OpenBSD ARM 32-bit armv7"
    ["gdrive-plan9-386"]="Plan 9 x86_64 32-bit"
    ["gdrive-plan9-amd64"]="Plan 9 x86_64 64-bit"
    ["gdrive-plan9-arm"]="Plan 9 ARM 32-bit"
    ["gdrive-solaris-amd64"]="Solaris x86_64 64-bit"
    ["gdrive-windows-386.exe"]="Windows x86_64 32-bit"
    ["gdrive-windows-amd64.exe"]="Windows x86_64 64-bit"
    ["gdrive-windows-arm.exe"]="Windows ARM 32-bit"
)

# Markdown helpers
HEADER='### Downloads
 Check our [releases](https://github.com/GrowtopiaJaw/gdrive/releases) section.

| Filename               | Version | Description        | SHA1SUM                                   |
|:-----------------------|:--------|:-------------------|:-----------------------------------------|'

ROW_TEMPLATE="| [{{name}}]({{url}}) | $VERSION | {{description}} | {{sha}} |"


# Print header
echo "$HEADER"

for name in ${filenames[@]}; do
    bin_path="$name"

    # Upload file
    url=$(githubrelease --github-token $gjaw_token --progress asset GrowtopiaJaw/gdrive upload $gdrive_tag $bin_path | awk '/https/ {print $2}')

    # Shasum
    sha="$(shasum -b $bin_path | awk '{print $1}')"

    # Filename
    name="$(basename $bin_path)"

    # Render markdown row
    row=${ROW_TEMPLATE//"{{name}}"/$name}
    row=${row//"{{url}}"/$url}
    row=${row//"{{description}}"/${descriptions[$name]}}
    row=${row//"{{sha}}"/$sha}

    # Print row
    echo "$row"
done
