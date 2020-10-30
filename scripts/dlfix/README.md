# Liferay Patch Download Script
Do you enjoy navigating the private files of Liferay in order to download that specific hotfix or patch for DXP?  This script is **NOT** for you!

This script has been setup so that you can quickly download the fixes that you need without opening a browser!

## Pre-requisite
This script makes use of the `~/.netrc` file in order to hide away your username and password for the private LR files.

1. Create ~/.netrc file.
2. Setup with the following lines:

```
machine files.liferay.com
login user.name
password liferay123
```

3. Save the file and close.

4. **Optional** (but highly reccommended) - to make it so that only YOU can open up this file which contains your password perform the following: `chmod 400 ~/.netrc` - this makes it so that only the owner-user can access it and nobody else can.  So keep your computer locked!

## Setup

1. Copy the contents of the 'dlfix.sh' into your bash profile
2. Save
3. Source your profile!

## How to Use

1. Navigate to your Liferay Home directory or patching-tool folder.
2. Call the function 'dlfix'

## Example

```
➜ dlfix
Select the Portal Version.

1) 7010  2) 7110  3) 7210
?# 2

You have selected  7110.

1) Hotfix   2) Fixpack
?# 2

What Patch Number?
10
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 192.168.0.1...
* TCP_NODELAY set
* Connected to files.liferay.com (192.168.0.1) port 80 (#0)
* Server auth using Basic with user 'first.last'
> GET /private/ee/fix-packs/7.1.10/dxp/liferay-fix-pack-dxp-10-7110.zip HTTP/1.1
> Host: files.liferay.com
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 200 OK
< Date: Tue, 10 Mar 2020 21:38:43 GMT
< Server: Apache
< Strict-Transport-Security: max-age=63072000; includeSubDomains
< Last-Modified: Tue, 16 Apr 2019 18:00:54 GMT
< Accept-Ranges: bytes
< Content-Length: 365386524
< Content-Type: application/zip
<
{ [2595 bytes data]
100  348M  100  348M    0     0  11.0M      0  0:00:31  0:00:31 --:--:-- 11.1M
* Connection #0 to host files.liferay.com left intact
* Closing connection 0
~/Liferay/builds/liferay-dxp-7.1.10.3-sp3

Downloaded liferay-fix-pack-dxp-10-7110.zip
```
