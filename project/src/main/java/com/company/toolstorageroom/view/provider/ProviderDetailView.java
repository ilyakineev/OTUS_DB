package com.company.toolstorageroom.view.provider;

import com.company.toolstorageroom.entity.Provider;

import com.company.toolstorageroom.view.main.MainView;

import com.vaadin.flow.router.Route;
import io.jmix.flowui.view.*;

@Route(value = "providers/:id", layout = MainView.class)
@ViewController("Provider.detail")
@ViewDescriptor("provider-detail-view.xml")
@EditedEntityContainer("providerDc")
public class ProviderDetailView extends StandardDetailView<Provider> {
}