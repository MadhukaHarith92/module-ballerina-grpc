#!/bin/bash -e
# Copyright 2021 WSO2 Inc. (http://wso2.org)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# ----------------------------------------------------------------------------
# Execution script for ballerina performance tests
# ----------------------------------------------------------------------------
#set -e
#source base-scenario.sh

#wget https://github.com/bojand/ghz/releases/download/v0.105.0/ghz-linux-x86_64.tar.gz
#tar -xf ghz-linux-x86_64.tar.gz
./ghz --insecure --proto ./demo.proto --rps 200 --call hipstershop.AdService.GetAds -d '{"context_keys":["photography", "gardening"]}' 0.0.0.0:9090 -O pretty > ghz_output.json
$baldev run ./process_output/ -- 50 "../results/summary.csv"