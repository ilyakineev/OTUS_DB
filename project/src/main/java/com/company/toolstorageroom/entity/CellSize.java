package com.company.toolstorageroom.entity;

import io.jmix.core.metamodel.datatype.EnumClass;

import org.springframework.lang.Nullable;


public enum CellSize implements EnumClass<String> {
    XS("1"),
    S("2"),
    M("3"),
    L("4"),
    XL("5");

    private final String id;

    CellSize(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    @Nullable
    public static CellSize fromId(String id) {
        for (CellSize at : CellSize.values()) {
            if (at.getId().equals(id)) {
                return at;
            }
        }
        return null;
    }
}