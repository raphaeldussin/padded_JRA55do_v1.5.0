# padded_JRA55do_v1.5.0

* install:

```
cd /archive/Raphael.Dussin/JRA55do/v1.5.0
git clone --recursive git@github.com:raphaeldussin/padded_JRA55do_v1.5.0.git padded
```

* pad files:

Create conda environment using the provided env file

```
conda create --name pad_jra --file conda_env
cond activate pad_jra
```

Then create the padded files

```
./pad_files_JRA55do_v1.5.0.bash
```

* Reproducibilty notes:

Files produced by the python-based **pad_forcing** code are virtually identical to those
produced by the older nco-based code, **EXCEPT** for the removal of a null character
in all netcdf attributes. Model solution reproduces bitwise between forcing created with
both padding codes when using recent versions of FMS. For older version of FMS, bitwise
reproducibility is **NOT** possible because of the bug reported here:

https://github.com/NOAA-GFDL/FMS/issues/551

Since the newly produced forcing does not have null characters in netcdf attributes,
It is not possible to recover the old answers using this flag:

```
<namelist name="data_override_nml">
       reproduce_null_char_bug=.true.
</namelist>
```
