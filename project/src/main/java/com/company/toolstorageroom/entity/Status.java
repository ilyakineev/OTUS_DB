package com.company.toolstorageroom.entity;

import io.jmix.core.metamodel.datatype.EnumClass;

import javax.annotation.Nullable;

public enum Status implements EnumClass<String> {
    PLACE_ON_STOCK("Размещен на складе"),
    ISSUE_TO_USER("Выдан пользователю"),
    START_USE("Используется"),
    SEND_FOR_SHARPENING("Затачивается"),
    SEND_FOR_REPAIR("Ремонтируется"),
    MARK_AS_FAULTY("Поломка"),
    RESERVE("Забронирован"),
    STORE_ON_STOCK("Хранится на складе"),
    INSPECT("На поверке"),
    RETURN("Возвращен"),
    DISPOSE("Утилизирован"),
    MARK_AS_LOST("Утерян"),
    WRITE_OFF("Списан"),
    MOVE("Перемещен");

    private final String id;

    Status(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    @Nullable
    public static Status fromId(String id) {
        for (Status at : Status.values()) {
            if (at.getId().equals(id)) {
                return at;
            }
        }
        return null;
    }
}