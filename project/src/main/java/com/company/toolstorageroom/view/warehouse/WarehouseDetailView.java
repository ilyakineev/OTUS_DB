package com.company.toolstorageroom.view.warehouse;

import com.company.toolstorageroom.entity.Warehouse;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "warehouses/:id", layout = MainView.class)
@ViewController("Warehouse.detail")
@ViewDescriptor("warehouse-detail-view.xml")
@EditedEntityContainer("warehouseDc")
public class WarehouseDetailView extends StandardDetailView<Warehouse> {
}