/* SpagoBI, the Open Source Business Intelligence suite

 * Copyright (C) 2012 Engineering Ingegneria Informatica S.p.A. - SpagoBI Competency Center
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0, without the "Incompatible With Secondary Licenses" notice.
 * If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/. */
package it.eng.qbe.runtime.query;

import it.eng.spagobi.tools.dataset.common.query.IAggregationFunction;

/**
 * @author Davide Zerbetto (davide.zerbetto@eng.it)
 *
 */
public class HavingField implements IQueryField {

	private String name;
	private String description;

	private boolean promptable;

	private Operand leftOperand;
	private String operator;
	private Operand rightOperand;

	private String booleanConnector;

	public static final String EQUALS_TO = "EQUALS TO";
	public static final String NOT_EQUALS_TO = "NOT EQUALS TO";
	public static final String GREATER_THAN = "GREATER THAN";
	public static final String EQUALS_OR_GREATER_THAN = "EQUALS OR GREATER THAN";
	public static final String LESS_THAN = "LESS THAN";
	public static final String EQUALS_OR_LESS_THAN = "EQUALS OR LESS THAN";
	public static final String STARTS_WITH = "STARTS WITH";
	public static final String NOT_STARTS_WITH = "NOT STARTS WITH";
	public static final String ENDS_WITH = "ENDS WITH";
	public static final String NOT_ENDS_WITH = "NOT ENDS WITH";
	public static final String NOT_NULL = "NOT NULL";
	public static final String IS_NULL = "IS NULL";
	public static final String CONTAINS = "CONTAINS";
	public static final String NOT_CONTAINS = "NOT CONTAINS";
	public static final String BETWEEN = "BETWEEN";
	public static final String NOT_BETWEEN = "NOT BETWEEN";
	public static final String IN = "IN";
	public static final String NOT_IN = "NOT IN";

	public HavingField(String name, String description, boolean promptable, Operand leftOperand, String operator, Operand rightOperand, String booleanConnector) {

		setName(name);
		setDescription(description);
		setPromptable(promptable);
		setLeftOperand(leftOperand);
		setOperator(operator);
		setRightOperand(rightOperand);
		setBooleanConnector(booleanConnector);
	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public String getAlias() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isPromptable() {
		return promptable;
	}

	public void setPromptable(boolean promptable) {
		this.promptable = promptable;
	}

	public Operand getLeftOperand() {
		return leftOperand;
	}

	public void setLeftOperand(Operand leftOperand) {
		this.leftOperand = leftOperand;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	public Operand getRightOperand() {
		return rightOperand;
	}

	public void setRightOperand(Operand rightOperand) {
		this.rightOperand = rightOperand;
	}

	public String getBooleanConnector() {
		return booleanConnector;
	}

	public void setBooleanConnector(String booleanConnector) {
		this.booleanConnector = booleanConnector;
	}

	public static class Operand extends it.eng.qbe.runtime.query.Operand {

		public IAggregationFunction function;

		public Operand(String[] values, String description, String type, String[] defaulttValues, String[] lastValues, IAggregationFunction function) {
			super(values, description, type, defaulttValues, lastValues, "");
			this.function = function;
		}
	}

}
