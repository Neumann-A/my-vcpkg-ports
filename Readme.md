To use this stuff:

```
git clone https://github.com/microsoft/vcpkg (somedir)
cd (somedir)
bootstrap.(bat|sh)
vcpkg install (someport) --overlay-ports=(path_to_this_dir)
```

commonly used by myself:

folder structure:  
```
top  
| - my-vcpkg-ports  
| - my-vcpkg-triplets  
| - vcpkg  
```
From top:  
```
cd vcpkg

./vcpkg install --overlay-ports=../my-vcpkg-ports --overlay-triplets=../my-vcpkg-triplets --triplet=x64-windows-llvm --host-triplet=x64-windows-llvm (someport) 

./vcpkg remove --overlay-ports=../my-vcpkg-ports --overlay-triplets=../my-vcpkg-triplets --triplet=x64-windows-llvm --host-triplet=x64-windows-llvm (someport)
```

Or from the projects manifest via:
```
  "vcpkg-configuration": {
    "overlay-ports": ["my-vcpkg-ports"],
    "overlay-triplets": ["my-vcpkg-triplets"]
  }
```
