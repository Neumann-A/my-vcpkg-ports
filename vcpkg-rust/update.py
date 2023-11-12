import argparse
import tomli
import requests
import hashlib

STABLE_CHANNEL_MANIFEST_URL = "https://static.rust-lang.org/dist/channel-rust-stable.toml"

ARCHITECTURES = [
    "i686-pc-windows-msvc",
    "x86_64-pc-windows-msvc",
    "i686-unknown-linux-gnu",
    "x86_64-unknown-linux-gnu",
]

PACKAGES = ["rustc", "rust-std", "cargo"]

def get_url_sha512(url):
    data = requests.get(url, stream = True)
    hasher = hashlib.sha512()
    for chunk in data.iter_content(chunk_size = None):
        hasher.update(chunk)
        
    return hasher.hexdigest()

def main(args):
    response = requests.get(STABLE_CHANNEL_MANIFEST_URL)
    manifest = tomli.loads(response.text)
    
    data = {}
    
    for arch in ARCHITECTURES:
        data[arch] = {}
        for package in PACKAGES:
            target = manifest[f"pkg"][package]["target"][arch]
            assert(target["available"])
            url = target["xz_url"]
            data[arch][package] = {"url": url, "sha512": get_url_sha512(url)}
      
    for arch in data:
        print(f"    # {arch}")
        for package in data[arch]:
            info = data[arch][package]
            print(f"    z_vcpkg_rust_acquire_declare_package(\n        URL \"{info['url']}\"\n        SHA512 {info['sha512']}\n    )")
            
        print("")
    
    

	

def parse_args():
	parser = argparse.ArgumentParser()
	return parser.parse_args()

if __name__ == "__main__":
    main(parse_args())	