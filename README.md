Fp Implementation written in CUDA/PTX
-----
This repo contains a highly optimized Fp implementation in CUDA PTX. No 
parallelisation is used, meaning that every thread is doing the same. The 
reduction is implementedas the Montgomery reduction. For the multiplication 
either the schoolbook or karatsuba implementation can be used. Also combinations
of both can be used. Additionally a everything is implemented either with 32- 
or 64 bit limbs.

The following functionallities are implemented:
	- mult
	- add
	- sub
	- sqr
	- mod

Build:
----

Run the following to prepare your system:
## arch:
```bash
sudo pacman -S make cmake cuda
````

## nix:
```bash
nix-shell
```


Then run the following to setup the code:
```bash
git clone https://github.com/FloydZ/cuda_fp_arithmetic
mkdir -p build
cd build
cmake ..
make
```

You can either test the code via:
```bash
./test_limb2
./test_limb3
./test_limb4
./test_limb5
./test_limb6
./test_limb7
```

or run benchmarks via:
```bash
bench
```
