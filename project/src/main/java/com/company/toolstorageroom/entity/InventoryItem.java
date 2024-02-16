package com.company.toolstorageroom.entity;

import io.jmix.core.entity.annotation.JmixGeneratedValue;
import io.jmix.core.metamodel.annotation.InstanceName;
import io.jmix.core.metamodel.annotation.JmixEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

@JmixEntity
@Table(name = "ITEM", indexes = {
        @Index(name = "IDX_ITEM_BATCH", columnList = "FK_BATCH"),
        @Index(name = "IDX_ITEM_WAREHOUSE", columnList = "FK_WAREHOUSE"),
        @Index(name = "IDX_ITEM_MANUFACTORY", columnList = "FK_MANUFACTORY")
})
@Entity
public class InventoryItem {
    @JmixGeneratedValue
    @Column(name = "ID", nullable = false)
    @Id
    private UUID id;

    @Column(name = "CATALOGUE_NUMBER", nullable = false)
    @NotNull
    private String inventoryCode;

    @InstanceName
    @Column(name = "NAME", nullable = false)
    @NotNull
    private String inventoryName;

    @JoinColumn(name = "FK_BATCH", nullable = false)
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Batch batch;

    @JoinColumn(name = "FK_WAREHOUSE", nullable = false)
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Warehouse warehouse;

    @JoinColumn(name = "FK_MANUFACTORY", nullable = false)
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Manufacturer manufactory;

    @Column(name = "STATUS", nullable = false)
    @NotNull
    private String status;

    @Column(name = "DESCRIPTION")
    private String description;

    public Status getStatus() {
        return status == null ? null : Status.fromId(status);
    }

    public void setStatus(Status status) {
        this.status = status == null ? null : status.getId();
    }

    public Manufacturer getManufactory() {
        return manufactory;
    }

    public void setManufactory(Manufacturer manufactory) {
        this.manufactory = manufactory;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public Batch getBatch() {
        return batch;
    }

    public void setBatch(Batch batch) {
        this.batch = batch;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getInventoryName() {
        return inventoryName;
    }

    public void setInventoryName(String name) {
        this.inventoryName = name;
    }

    public String getInventoryCode() {
        return inventoryCode;
    }

    public void setInventoryCode(String catalogue_number) {
        this.inventoryCode = catalogue_number;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }
}