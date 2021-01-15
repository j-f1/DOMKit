# DOMKit

🚨 Very experimental 🚨

Type-safe access to DOM APIs from Swift, using [webidl2swift](https://github.com/Apodini/webidl2swift/pull/8) to generate the bindings and [JavaScriptKit](https://github.com/swiftwasm/JavaScriptKit) to enable access to the actual objects.

## Contributing

```sh
cd deps
# clone my fork of webidl2swift
git clone -b full-dom-spec https://github.com/j-f1/forked-webidl2swift webidl2swift
# clone my WebIDL downloader
git clone https://github.com/j-f1/bs-to-idl
# download the specs
./dl-specs.sh

cd webidl2swift/
swift run webidl2swift -i ../webidl-sources -o ../output --no-pretty-print
cd ../../
cp deps/output/WebAPI/Sources/WebAPI/* ./Sources/DOMKit/WebIDL/
swiftformat ./Sources/DOMKit/WebIDL/
```
