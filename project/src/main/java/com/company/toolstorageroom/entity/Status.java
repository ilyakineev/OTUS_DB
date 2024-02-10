package com.company.toolstorageroom.entity;

import io.jmix.core.metamodel.datatype.EnumClass;

import javax.annotation.Nullable;

public enum Status implements EnumClass<String> {
    PLACE_ON_STOCK("Размещение на складе"),
    ISSUE_TO_USER("Выдача пользователю"),
    START_USE("Начало использования"),
    SEND_FOR_SHARPENING("Отправка на заточку"),
    SEND_FOR_REPAIR("Передача на ремонт"),
    MARK_AS_FAULTY("Пометка как неисправный"),
    RESERVE("Бронирование"),
    STORE_ON_STOCK("Хранение на складе"),
    INSPECT("Проверка"),
    RETURN("Возврат"),
    DISPOSE("Утилизация"),
    MARK_AS_LOST("Пометка как потерянный"),
    WRITE_OFF("Списание"),
    MOVE("Перемещение");

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