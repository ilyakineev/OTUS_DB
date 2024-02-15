package com.company.toolstorageroom.view.warehouse;

import com.company.toolstorageroom.entity.Warehouse;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "warehouses", layout = MainView.class)
@ViewController("Warehouse.list")
@ViewDescriptor("warehouse-list-view.xml")
@LookupComponent("warehousesDataGrid")
@DialogMode(width = "64em")
public class WarehouseListView extends StandardListView<Warehouse> {
}