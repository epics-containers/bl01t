#!/bin/bash

# a bash script to source in order to set up your command line to interact with
# a specific beamline. This needs to be customized per beamline / domain

# check we are sourced
if [ "$0" = "$BASH_SOURCE" ]; then
    echo "ERROR: Please source this script"
    exit 1
fi

THIS_DIR=$(dirname ${0})

echo "Loading IOC environment for example beamline bl01t ..."

#### SECTION 1. Environment variables ##########################################

# a mapping between genenric IOC repo roots and the related container registry
# use spaces to separate multiple mappings
export EC_REGISTRY_MAPPING='github.com=ghcr.io'
# the namespace to use for kubernetes deployments - local = local docker/podman
export EC_K8S_NAMESPACE=local
# the git repo for this beamline (or accelerator domain)
export EC_DOMAIN_REPO=git@github.com:epics-containers/bl01t.git
# declare your centralised log server Web UI
# export EC_LOG_URL='https://graylog2.diamond.ac.uk/search?rangetype=relative&fields=message%2Csource&width=1489&highlightMessage=&relative=172800&q=pod_name%3A{ioc_name}*'
# enforce a specific container cli - defaults to whatever is available
# export EC_CONTAINER_CLI=podman
# enable debug output in all 'ec' commands
# export EC_DEBUG=1


#### SECTION 2. Install ec #####################################################

#  make sure we have ec CLI installed
if ! ec --version &> /dev/null; then
    echo '
Please install ec CLI from https://github.com/epics-containers/epics-containers-cli

Requires Python 3.9 or later.

Use the following command to install:
  python3 -mvenv venv
  source venv/bin/activate
  pip install epics-containers-cl
  source environment.sh
'
    return 1
else
    # enable shell completion for ec commands
    source <(ec --show-completion ${SHELL})
fi

#### SECTION 3. Configure Kubernetes Cluster ###################################
# example of how we set up a cluster at DLS is below
# SET UP Connection to KUBERNETES CLUSTER and set default namespace.
# if module --version &> /dev/null; then
#     if module avail k8s-ixx > /dev/null; then
#         module unload k8s-ixx > /dev/null
#         module load k8s-ixx > /dev/null
#         # set the default namespace for kubectl and helm (for convenience only)
#         kubectl config set-context --current --namespace=ixx-iocs
#         # get running iocs: makes sure the user has provided credentials
#         ec ps
#     fi
# fi


