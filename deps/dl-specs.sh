#!/bin/sh

rm -rf webidl-sources
mkdir webidl-sources

cd webidl2swift/Example
npm install
npm run generate-webidl
cp WebIDL-files/{dom,html}.webidl ../../webidl-sources/
cd ../../

bs-to-idl/from-github.sh https://github.com/whatwg/console/blob/master/index.bs webidl-sources/console.webidl &
bs-to-idl/from-github.sh https://github.com/whatwg/encoding/blob/master/encoding.bs webidl-sources/encoding.webidl &
bs-to-idl/from-github.sh https://github.com/whatwg/fetch/blob/master/fetch.bs webidl-sources/fetch.webidl &
bs-to-idl/from-github.sh https://github.com/whatwg/streams/blob/master/index.bs webidl-sources/streams.webidl &
bs-to-idl/from-github.sh https://github.com/whatwg/url/blob/master/url.bs webidl-sources/url.webidl &
bs-to-idl/from-github.sh https://github.com/whatwg/fullscreen/blob/master/fullscreen.bs webidl-sources/fullscreen.webidl &
bs-to-idl/from-github.sh https://github.com/whatwg/notifications/blob/master/notifications.bs webidl-sources/notifications.webidl &
bs-to-idl/from-github.sh https://github.com/whatwg/xhr/blob/master/xhr.bs webidl-sources/xhr.webidl &
bs-to-idl/from-github.sh https://github.com/w3c/webappsec-referrer-policy/blob/master/index.src.html webidl-sources/referrer-policy.webidl &
bs-to-idl/from-github.sh https://github.com/heycam/webidl/blob/master/index.bs webidl-sources/webidl.webidl noindent &
bs-to-idl/from-github.sh https://github.com/w3c/FileAPI/blob/master/index.bs webidl-sources/file.webidl &
bs-to-idl/from-github.sh https://github.com/w3c/hr-time/blob/gh-pages/index.html webidl-sources/hr-time.webidl &
bs-to-idl/from-github.sh https://github.com/w3c/ServiceWorker/blob/master/docs/index.bs webidl-sources/service-worker.webidl &
bs-to-idl/from-github.sh https://github.com/w3c/fxtf-drafts/blob/master/geometry/Overview.bs webidl-sources/geometry.webidl &
bs-to-idl/from-github.sh https://github.com/w3c/aria/blob/master/index.html webidl-sources/aria.webidl &
bs-to-idl/from-github.sh https://github.com/w3c/aria/blob/master/index.html webidl-sources/aria.webidl &
bs-to-idl/from-github.sh https://github.com/w3c/csswg-drafts/blob/master/cssom-1/Overview.bs webidl-sources/cssom.webidl &
curl https://www.khronos.org/registry/webgl/specs/1.0.3/webgl.idl > webidl-sources/webgl.webidl
curl https://www.khronos.org/registry/webgl/specs/2.0/webgl2.idl > webidl-sources/webgl2.webidl

# TODO: remove HTML comments from ARIA spec IDL
# TODO: https://github.com/w3c/media-source/
# TODO: https://github.com/w3c/uievents (multiple files)
# TODO: https://svgwg.org/svg2-draft/ (multiple files)
# TODO: https://github.com/w3c/page-visibility/blob/gh-pages/index.html
# TODO: something special for WindowProxy (maybe just typealias it to Window? because the actual Window is inaccessible)

wait


# Not currently used:
# bs-to-idl/from-github.sh https://github.com/whatwg/storage/blob/master/storage.bs webidl-sources/storage.webidl &
