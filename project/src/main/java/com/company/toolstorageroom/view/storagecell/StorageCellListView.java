package com.company.toolstorageroom.view.storagecell;

import com.company.toolstorageroom.entity.StorageCell;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "storageCells", layout = MainView.class)
@ViewController("StorageCell.list")
@ViewDescriptor("storage-cell-list-view.xml")
@LookupComponent("storageCellsDataGrid")
@DialogMode(width = "64em")
public class StorageCellListView extends StandardListView<StorageCell> {
}