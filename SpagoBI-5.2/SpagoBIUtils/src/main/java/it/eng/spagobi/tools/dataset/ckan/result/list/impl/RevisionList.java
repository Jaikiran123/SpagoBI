/*
CKANClient-J - Data Catalogue Software client in Java
Copyright (C) 2013 Newcastle University

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package it.eng.spagobi.tools.dataset.ckan.result.list.impl;

import it.eng.spagobi.tools.dataset.ckan.resource.impl.Revision;
import it.eng.spagobi.tools.dataset.ckan.result.CKANResult;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 *
 * @author Andrew Martin <andrew.martin@ncl.ac.uk>
 * @version 1.8
 * @since 2013-02-18
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class RevisionList extends CKANResult {
	private List<Revision> result;

	public List<Revision> getResult() {
		return result;
	}

	public void setResult(List<Revision> result) {
		this.result = result;
	}
}
