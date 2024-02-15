package com.company.toolstorageroom.view.inventoryitem;

import com.company.toolstorageroom.entity.InventoryItem;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "inventoryItems", layout = MainView.class)
@ViewController("InventoryItem.list")
@ViewDescriptor("inventory-item-list-view.xml")
@LookupComponent("inventoryItemsDataGrid")
@DialogMode(width = "64em")
public class InventoryItemListView extends StandardListView<InventoryItem> {
}