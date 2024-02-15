package com.company.toolstorageroom.view.manufacturer;

import com.company.toolstorageroom.entity.Manufacturer;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "manufacturers", layout = MainView.class)
@ViewController("Manufacturer.list")
@ViewDescriptor("manufacturer-list-view.xml")
@LookupComponent("manufacturersDataGrid")
@DialogMode(width = "64em")
public class ManufacturerListView extends StandardListView<Manufacturer> {
}