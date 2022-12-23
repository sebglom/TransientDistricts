TransientDistricts
----

This is a fork of the original TransiEnt-Modelica Library. The original projekt can be found [here](https://github.com/TransiEnt-official/transient-lib)

### Installation

1. Download transient-lib and copy the library to your preferred folder

Currently, only Dymola provides full suppport of TransiEnt. The development team has tested all models carefully using Dymola 2022x.

2. Download the ClaRa library from the official website https://www.claralib.com/ and copy unzipped library files into! the transient-lib folder

3. Open the Library using a MOS Script

In order to use the TransiEnt Library a few external libraries have to be loaded and some modelica environment variables have to be set. You can perform all required steps automatically by running the script loadTransiEnt.mos located in the directory where the TransiEnt Library is located on your computer.

Before doing this, you have to replace ```"ADD_YOUR_PATH_TO_TRANSIENT_HERE"``` (Line 2 of loadTransiEnt.mos) with the absolute path to the directory where the transient Library is located. Line 2 should look something like the following (use front slashes):

```repopath="d:$DYMOLA$/Modelica/Library/TransiEnt";```

Furthermore, you should replace ```"ADD_YOUR_PATH_FOR_RESULTS_HERE"``` (Line 3 of loadTransiEnt.mos)  with the absolute path to the directory where you want to save your results. This enables you to call the functions named 'plotResults' in the Examples and Testers of the Library which will show you some relevant simulation results. Line 3 should look something like this (use front slashes):

```resultpath="c:/simulationsresults";```

Please make sure that this directory exists (will not be created automatically).

The libraries required and automatically loaded by the script are the following:
* TransiEnt ("Simulation of coupled energy networks")
* ClaRa ("Simulation fo Clausius Rankine Cycles")
* TILMedia (for the calculation of media data)

Additionally the Modelica Library "Buildings Library" is necessary for certain components of the TransiEnt Library.

Note: The models of FluidDissipation library which are important for the use of TransiEnt Library, are now part of ClaRa v.1.3.0 and therefore not additionally listed anymore.

The script can be called from dymola by Simulation -> Simulation -> Script -> RunScript

Alternatively you can add the script to your dymola.mos to load TransiEnt automatically every time dymola is started. The dymola.mos is located in ```$DYMOLA_INSTALLATION_FOLDER$/insert/dymola.mos```. The required line would look like this:

```RunScript("d:$DYMOLA$/Modelica/Library/TransiEnt/loadWorkspace.mos")```

