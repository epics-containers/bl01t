Example epics containers Beamline Repository
============================================

This example is intended as a playground for trying out epics-containers.

There are two IOC instances in this repo:

1. bl01t-ea-ioc-02 is an ADSimDetector simulation 2D detector
2. bl01t-mo-ioc-01 is a simulation motion controller with 8 axes

To try out this example you will need docker or podman installed on your system.
You will also need python version 3.9 or higher.

Instructions to run an example:

1. Clone this repository
2. Activate a Python virtual environment
4. Install the python dependencies (the `ec` command line tool)
5. source environment.sh` to set up the environment for the sample beamline.
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

Note with all `ec` commands if you want to see the commands it is calling use
`ec -v ...` also `ec --help` will show you the available commands. Also
you should have tab completion for the `ec` command.

To install the latest released example motion IOC and verify it is running:

```bash
ec ioc deploy bl01t-mo-ioc-01 2023.11.1
ec ps
```

Attach to the IOC console and check the set of PVs it has:

```bash
ec ioc attach bl01t-mo-ioc-01
dbl
# ctrl-Q ctrl-P to detach
```

Now you can move some motors with e.g.:

```bash
caput BL01T-MO-IOC-01:M1 500
camonitor BL01T-MO-IOC-01:M1.RBV
```

And if you don't have EPICS installed locally you can use the `ec` command to
start a shell inside the container which does have epics installed:

```bash
ec ioc exec bl01t-mo-ioc-01

caput BL01T-MO-IOC-01:M1 500
camonitor BL01T-MO-IOC-01:M1.RBV

# ctrl-d to exit

```


