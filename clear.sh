#!/bin/bash

find . -type f -name "*.o" -delete
find . -type f -executable -not -name "*.sh" -delete
