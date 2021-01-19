// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/auth;

# Represents credentials for Basic Auth authentication.
public type CredentialsConfig record {|
    *auth:CredentialsConfig;
|};

# Defines the Basic Auth handler for client authentication.
public class ClientBasicAuthHandler {

    auth:ClientBasicAuthProvider provider;

    # Initializes the `http:ClientBasicAuthHandler` object.
    #
    # + config - The `http:CredentialsConfig` instance
    public isolated function init(CredentialsConfig config) {
        self.provider = new(config);
    }

    # Enrich the headers with the relevant authentication requirements.
    #
    # + headers - The headers map `map<string[]>` as an input
    # + return - The updated headers map `map<string[]>` instance or else an `grpc:ClientAuthError` in case of an error
    public isolated function enrich(map<string[]> headers) returns map<string[]>|ClientAuthError {
        string|auth:Error result = self.provider.generateToken();
        if (result is auth:Error) {
            return prepareClientAuthError("Failed to enrich request with Basic Auth token.", result);
        }
        string token = AUTH_SCHEME_BASIC + " " + checkpanic result;
        headers[AUTH_HEADER] = [token];
        return headers;
    }
}