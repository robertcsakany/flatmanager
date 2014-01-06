package org.liveSense.sample.flatmanager.server.rest.api;

import javax.xml.bind.annotation.XmlEnum;
import javax.xml.bind.annotation.XmlEnumValue;

@XmlEnum
public enum ActivationType {
    @XmlEnumValue(value = "OWNERREGISTRATION")
    OWNERREGISTRATION,
    @XmlEnumValue(value = "RENTERREGISTRATION")
    RENTERREGISTRATION
}