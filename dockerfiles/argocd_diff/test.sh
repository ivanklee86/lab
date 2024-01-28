#!/bin/bash

gomplate -f diff.md.tmpl -o diff.md -d diff=k8s.diff?type=text/plain
