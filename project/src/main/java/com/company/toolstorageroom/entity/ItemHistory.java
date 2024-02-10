package com.company.toolstorageroom.entity;

import io.jmix.core.entity.annotation.JmixGeneratedValue;
import io.jmix.core.metamodel.annotation.InstanceName;
import io.jmix.core.metamodel.annotation.JmixEntity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDateTime;
import java.util.UUID;

@JmixEntity
@Table(name = "ITEM_HISTORY", indexes = {
        @Index(name = "IDX_ITEM_HISTORY_ITEM", columnList = "FK_ITEM")
})
@Entity
public class ItemHistory {
    @JmixGeneratedValue
    @Column(name = "ID", nullable = false)
    @Id
    private UUID id;

    @Column(name = "OPERATION", nullable = false)
    @NotNull
    private String operation;

    @JoinColumn(name = "FK_ITEM", nullable = false)
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private InventoryItem inventoryitem;

    @JoinColumn(name = "FK_USER")
    @OneToOne(fetch = FetchType.LAZY)
    private User responsibleUser;

    @Column(name = "TIME_", nullable = false)
    @NotNull
    private LocalDateTime time;

    @InstanceName
    @Column(name = "DESCRIPTION")
    private String description;

    public void setResponsibleUser(User user) {
        this.responsibleUser = user;
    }

    public User getResponsibleUser() {
        return responsibleUser;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public InventoryItem getInventoryitem() {
        return inventoryitem;
    }

    public void setInventoryitem(InventoryItem item) {
        this.inventoryitem = item;
    }

    public Operation getOperation() {
        return operation == null ? null : Operation.fromId(operation);
    }

    public void setOperation(Operation operation) {
        this.operation = operation == null ? null : operation.getId();
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }
}