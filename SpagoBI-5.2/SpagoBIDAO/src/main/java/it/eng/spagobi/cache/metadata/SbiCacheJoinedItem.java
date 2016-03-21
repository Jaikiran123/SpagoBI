/* SpagoBI, the Open Source Business Intelligence suite

 * Copyright (C) 2012 Engineering Ingegneria Informatica S.p.A. - SpagoBI Competency Center
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0, without the "Incompatible With Secondary Licenses" notice.
 * If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/. */

package it.eng.spagobi.cache.metadata;

import it.eng.spagobi.commons.metadata.SbiHibernateModel;

// Generated 21-mag-2015 12.23.29 by Hibernate Tools 3.4.0.CR1

/**
 * SbiCacheJoinedItem generated by hbm2java
 */
public class SbiCacheJoinedItem extends SbiHibernateModel {

	private int id;
	private SbiCacheItem sbiCacheItemBySignature;
	private SbiCacheItem sbiCacheItemByJoinedSignature;

	public SbiCacheJoinedItem() {
	}

	public SbiCacheJoinedItem(int id, SbiCacheItem sbiCacheItemBySignature, SbiCacheItem sbiCacheItemByJoinedSignature) {
		this.id = id;
		this.sbiCacheItemBySignature = sbiCacheItemBySignature;
		this.sbiCacheItemByJoinedSignature = sbiCacheItemByJoinedSignature;
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public SbiCacheItem getSbiCacheItemBySignature() {
		return this.sbiCacheItemBySignature;
	}

	public void setSbiCacheItemBySignature(SbiCacheItem sbiCacheItemBySignature) {
		this.sbiCacheItemBySignature = sbiCacheItemBySignature;
	}

	public SbiCacheItem getSbiCacheItemByJoinedSignature() {
		return this.sbiCacheItemByJoinedSignature;
	}

	public void setSbiCacheItemByJoinedSignature(SbiCacheItem sbiCacheItemByJoinedSignature) {
		this.sbiCacheItemByJoinedSignature = sbiCacheItemByJoinedSignature;
	}

}
