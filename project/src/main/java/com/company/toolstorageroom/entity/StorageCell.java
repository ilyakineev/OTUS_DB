package com.company.toolstorageroom.entity;

import io.jmix.core.entity.annotation.JmixGeneratedValue;
import io.jmix.core.metamodel.annotation.JmixEntity;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

import java.util.List;
import java.util.UUID;

@JmixEntity
@Table(name = "STORAGE_CELL", indexes = {
        @Index(name = "IDX_STORAGE_CELL_WAREHOUSE", columnList = "WAREHOUSE_ID")
})
@Entity
public class StorageCell {
    @JmixGeneratedValue
    @Column(name = "ID", nullable = false)
    @Id
    private UUID id;

    @JoinColumn(name = "WAREHOUSE_ID", nullable = false)
    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Warehouse warehouse;

    @Column(name = "CELL_NUMBER", nullable = false)
    @NotNull
    private Integer cellNumber;

    @Column(name = "CELL_SIZE", nullable = false)
    @NotNull
    private String cellSize;

    @NotNull
    @JoinTable(name = "STORAGE_CELL_INVENTORY_ITEM_LINK",
            joinColumns = @JoinColumn(name = "STORAGE_CELL_ID", referencedColumnName = "ID"),
            inverseJoinColumns = @JoinColumn(name = "INVENTORY_ITEM_ID", referencedColumnName = "ID"))
    @ManyToMany
    private List<InventoryItem> item;

    public List<InventoryItem> getItem() {
        return item;
    }

    public void setItem(List<InventoryItem> item) {
        this.item = item;
    }

    public CellSize getCellSize() {
        return cellSize == null ? null : CellSize.fromId(cellSize);
    }

    public void setCellSize(CellSize cellSize) {
        this.cellSize = cellSize == null ? null : cellSize.getId();
    }

    public Integer getCellNumber() {
        return cellNumber;
    }

    public void setCellNumber(Integer cellNumber) {
        this.cellNumber = cellNumber;
    }

    public Warehouse getWarehouse() {
        return warehouse;
    }

    public void setWarehouse(Warehouse warehouse) {
        this.warehouse = warehouse;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }
}