#!/bin/bash

find "/scripts/" -name "docker_*.sh" -type f -exec bash "{}" \;
