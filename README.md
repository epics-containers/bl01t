Example epics containers Beamline Repository
============================================

This example is intended as a playground for trying out epics-containers.

There are two IOC instances in this repo:

1. bl01t-ea-ioc-02 is an ADSimDetector simulation 2D detector
2. bl01t-mo-ioc-01 is a simulation motion controller with 8 axes


## Trying out the motion IOC

To try out this example you will need docker or podman installed on your system.
You will also need python version 3.9 or higher.

Instructions to run an example:

1. Clone this repository
2. Activate a Python virtual environment
4. Install the python dependencies (the `ec` command line tool)
5. source environment.sh to set up the environment for the sample beamline.
   This command sets up the environment so that `ec` knows where to install IOC
   instances and where to find their releases.

Cut and paste the following to perform the above steps:

```bash
git clone git@github.com:epics-containers/bl01t.git
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
source environment.sh
```

You are now set up to try out some IOC instances.

Note with all `ec` commands if you want to see what it is doing use
`ec -v ...` also `ec --help` will show you the available commands. Also
you should have tab completion for the `ec` command.

To install the latest released example motion IOC and verify it is running:

```bash
ec ioc deploy bl01t-mo-ioc-01 2023.11.1
ec ps
ec ioc logs bl01t-mo-ioc-01
```

Attach to the IOC console and check the set of PVs it has:

```bash
ec ioc attach bl01t-mo-ioc-01
dbl
# ctrl-P ctrl-Q to detach
```

Now you can move some motors with e.g.:

```bash
caput BL01T-MO-TST-01:M1 500
camonitor BL01T-MO-TST-01:M1.RBV
```

And if you don't have EPICS installed locally you can use the `ec` command to
start a shell inside the container which does have epics installed:

```bash
ec ioc exec bl01t-mo-ioc-01

caput BL01T-MO-IOC-01:M1 500
camonitor BL01T-MO-IOC-01:M1.RBV

# ctrl-d to exit
```

## Making local changes

To try changing the IOC Instance you can edit the description file in
iocs/bl01t-mo-ioc-01/config/bl01t-mo-ioc-01.yml and then run:

```bash
ec ioc deploy-local iocs/bl01t-mo-ioc-01
```

Once you are happy with your changes you can push to a fork of this repo and
tag it. Then repeat the `ec ioc deploy` command above but with the new tag.

## Working in a devcontainer

TODO more details to follow.

The IOC instance is based upon the `ioc-simmotor` Generic IOC image.
To work on the instance, the generic IOC and its support modules at the same
time you can use the `devcontainer` feature of VSCode.

```bash
git clone https://github.com/epics-containers/ioc-motorsim
code ioc-motorsim
# choose open in container option
```

For detailed instructions see:
[devcontainer tutorial](https://epics-containers.github.io/main/user/tutorials/dev_container.html)
and subsequent tutorials.

## Trying out the detector IOC

TODO: more details to follow.

For some info to help with trying the detector IOC see
[ioc-simdetector README](https://github.com/epics-containers/ioc-adsimdetector#adsimdetector-generic-ioc-for-epics-containers)

Or you could try the tutorial at
[epics-containers Tutorials](https://epics-containers.github.io/main/user/tutorials/intro.html)
these will walk your through setting up a workstation, making a beamline
and testing a SimDetector IOC instance.
