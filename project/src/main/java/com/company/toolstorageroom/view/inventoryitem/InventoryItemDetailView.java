package com.company.toolstorageroom.view.inventoryitem;

import com.company.toolstorageroom.entity.InventoryItem;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "inventoryItems/:id", layout = MainView.class)
@ViewController("InventoryItem.detail")
@ViewDescriptor("inventory-item-detail-view.xml")
@EditedEntityContainer("inventoryItemDc")
public class InventoryItemDetailView extends StandardDetailView<InventoryItem> {
}