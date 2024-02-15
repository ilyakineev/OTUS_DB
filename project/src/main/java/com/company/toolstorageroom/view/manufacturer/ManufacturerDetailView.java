package com.company.toolstorageroom.view.manufacturer;

import com.company.toolstorageroom.entity.Manufacturer;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "manufacturers/:id", layout = MainView.class)
@ViewController("Manufacturer.detail")
@ViewDescriptor("manufacturer-detail-view.xml")
@EditedEntityContainer("manufacturerDc")
public class ManufacturerDetailView extends StandardDetailView<Manufacturer> {
}