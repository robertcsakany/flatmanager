package org.liveSense.sample.flatmanager.server.rest.api;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlEnumValue;

@XmlEnum
public enum UserType {
	@XmlEnumValue(value = "OWNER")
	OWNER,
	@XmlEnumValue(value = "RENTER")
	RENTER
}