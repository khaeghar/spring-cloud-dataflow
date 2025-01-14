/*
 * Copyright 2015-2018 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.springframework.cloud.dataflow.rest.resource;

import org.springframework.cloud.dataflow.core.Account;
import org.springframework.cloud.deployer.spi.kubernetes.KubernetesDeployerProperties;
import org.springframework.hateoas.RepresentationModel;

/**
 * A HATEOAS representation of a {@link Account}.
 *
 */
public class AccountResource extends RepresentationModel<AccountResource> {

	private String accountName;

	private KubernetesDeployerProperties properties;

	/**
	 * @return the accountName
	 */
	public String getAccountName() {
		return accountName;
	}

	/**
	 * @param accountName the accountName to set
	 */
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	/**
	 * @return the properties
	 */
	public KubernetesDeployerProperties getProperties() {
		return properties;
	}

	/**
	 * @param properties the properties to set
	 */
	public void setProperties(KubernetesDeployerProperties properties) {
		this.properties = properties;
	}

	public AccountResource(String accountName, KubernetesDeployerProperties properties) {
		super();
		this.accountName = accountName;
		this.properties = properties;
	}

	public AccountResource() {
		super();
	}

}
